class Product < ActiveRecord::Base
  belongs_to :locale
  belongs_to :product_category

  has_many :benefit_products
  has_many :benefits, through: :benefit_products

  has_many :product_option_types, dependent: :destroy, inverse_of: :product
  has_many :option_types, through: :product_option_types

  has_and_belongs_to_many :skin_types
  has_and_belongs_to_many :regimens


  has_one :master,
      -> { where is_master: true },
      inverse_of: :product,
      class_name: 'Variant'

  has_many :variants,
      -> { where(is_master: false) },
      inverse_of: :product,
      class_name: 'Variant'

  has_many :variants_including_master,
      inverse_of: :product,
      class_name: 'Variant',
      dependent: :destroy


  validates :name, presence: true

  after_create :assign_locale
  after_create :set_master_variant_defaults
  after_initialize :ensure_master
  after_save :save_master
  after_save :run_touch_callbacks, if: :anything_changed?
  after_save :reset_nested_changes

  accepts_nested_attributes_for :variants, :allow_destroy => true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }


  # the master variant is not a member of the variants array
  def has_variants?
    variants.any?
  end

  # # split variants list into hash which shows mapping of opt value onto matching variants
  # # eg categorise_variants_from_option(color) => {"red" -> [...], "blue" -> [...]}
  def categorise_variants_from_option(opt_type)
    return {} unless option_types.include?(opt_type)
    variants.active.group_by { |v| v.option_values.detect { |o| o.option_type == opt_type} }
  end

  def master_code
    self.master.code
  end

  def master_upc
    self.master.upc
  end

  def master_price
    self.master.price
  end

  def master_size

    self.master.option_values
    # self.master.save
    # var_id = self.master.id


  end

  def update_variants(params)
    product = Product.find(params["product_id"])

    if product.master.code == params["code"]
    else
      product.master.code = params["code"]
    end
    if product.master.code == params["upc"]
    else
      product.master.upc = params["upc"]
    end
    if product.master.price.to_digits == params["price"]
    else
      product.master.price = params["price"]
    end

    opt_val_var = OptionValuesVariant.where(variant_id: product.master.id)


    if opt_val_var.any?
      opt_val_var.each do |var|
        if params["size"].present?
          var.option_value_id = params["size"].to_i
          var.save
        else
          var.delete
        end
      end
    else
      if params["size"].present?
        opt = OptionValue.find(params["size"])
        if product.master.option_values.includes(:option_values).where(id: opt.id).any?

        else
          product.master.option_values_variants.create({option_value_id: opt.id})
        end
      end
    end

    product.master.save
  end

  # Suitable for displaying only variants that has at least one option value.
  # There may be scenarios where an option type is removed and along with it
  # all option values. At that point all variants associated with only those
  # values should not be displayed to frontend users. Otherwise it breaks the
  # idea of having variants
  def variants_and_option_values(current_currency = nil)
    variants.includes(:option_values).active(current_currency).select do |variant|
      variant.option_values.any?
    end
  end

  # def empty_option_values?
  #   options.empty? || options.any? do |opt|
  #     opt.option_type.option_values.empty?
  #   end
  # end

  # Master variant may be deleted (i.e. when the product is deleted)
  # which would make AR's default finder return nil.
  # This is a stopgap for that little problem.
  def master
    super || variants_including_master.where(is_master: true).first
  end

  def self.user_scope
    where(locale_id: Rails.application.config.user_locale_id)
  end

  private



  # Builds variants from a hash of option types & values
  def build_variants_from_option_values_hash
    ensure_option_types_exist_for_values_hash
    values = option_values_hash.values
    values = values.inject(values.shift) { |memo, value| memo.product(value).map(&:flatten) }

    values.each do |ids|
      variant = variants.create(
        option_value_ids: ids,
        price: master.price
      )
    end
    save
  end

  def anything_changed?
    changed? || @nested_changes
  end

  def reset_nested_changes
    @nested_changes = false
  end

  def ensure_master
    return unless new_record?
    self.master ||= build_master
  end

  def set_master_variant_defaults
    # TODO set option types
    master.is_master = true
    master.price = self.price
  end

  def master_updated?

    if self.new_record? || self.changed?
      #self.master.price = self.price
      self.master.position = self.position
      self.master.save!
    end
  end

  # # there's a weird quirk with the delegate stuff that does not automatically save the delegate object
  # # when saving so we force a save using a hook
  # # Fix for issue #5306
  def save_master
    if master_updated?
      master.save!
      @nested_changes = true
    end
  end


  # # If the master cannot be saved, the Product object will get its errors
  # # and will be destroyed
  def validate_master
  #   # We call master.default_price here to ensure price is initialized.
  #   # Required to avoid Variant#check_price validation failing on create.
    unless master.default_price && master.valid?
      master.errors.each do |att, error|
        self.errors.add(att, error)
      end
    end
  end


  def run_touch_callbacks
    run_callbacks(:touch)
  end
  # # ensures the master variant is flagged as such
  def set_master_variant_defaults
    master.position = position
    #master.price = price
    master.is_master = true
  end

  def assign_locale
    unless self.locale_id.present?
      self.locale_id = Rails.application.config.user_locale_id
      self.save!
    end
  end

end

