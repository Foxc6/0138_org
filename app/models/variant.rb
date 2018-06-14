class Variant < ActiveRecord::Base
  belongs_to :product,touch: true, inverse_of: :variants
  has_many :option_values_variants
  has_and_belongs_to_many :option_values, join_table: :option_values_variants

  validates_uniqueness_of :code, allow_blank: true, conditions: -> { where(deleted_at: nil) }

  accepts_nested_attributes_for :option_values_variants, :allow_destroy => true


  # Product may be created with deleted_at already set,
  # which would make AR's default finder return nil.
  # This is a stopgap for that little problem.
  def product
    Product.unscoped { super }
  end

  def options=(options = {})
    options.each do |option|
      set_option_value(option["name"], option["value"])
    end
  end

  def set_option_value(opt_name, opt_value)
    # no option values on master
    return if self.is_master

    option_type = OptionType.where(name: opt_name).first_or_initialize do |o|
      o.presentation = opt_name
      o.save!
    end

    current_value = self.option_values.detect { |o| o.option_type.name == opt_name }

    unless current_value.nil?
      return if current_value.name == opt_value
      self.option_values.delete(current_value)
    else
      # then we have to check to make sure that the product has the option type
      unless self.product.option_types.include? option_type
        self.product.option_types << option_type
      end
    end

    option_value = OptionValue.where(option_type_id: option_type.id, name: opt_value).first_or_initialize do |o|
      o.presentation = opt_value
      o.save!
    end

    self.option_values << option_value
    self.save
  end

  def price_modifier_amount_in(currency, options = {})
      return 0 unless options.present?

      options.keys.map { |key|
        m = "#{key}_price_modifier_amount_in".to_sym
        if self.respond_to? m
          self.send(m, currency, options[key])
        else
          0
        end
      }.sum
    end

  def option_value(opt_name)
    self.option_values.detect { |o| o.option_type.name == opt_name }.try(:presentation)
  end
end
