class OptionType < ActiveRecord::Base
  has_many :option_values, -> { order(:position) }, dependent: :destroy, inverse_of: :option_type

  validates :name, presence: true, uniqueness: true
  validates :presentation, presence: true
  has_many :product_option_types, dependent: :destroy, inverse_of: :option_type
  has_many :products, through: :product_option_types
  accepts_nested_attributes_for :option_values, reject_if: lambda { |ov| ov[:name].blank? || ov[:presentation].blank? }, allow_destroy: true

  after_touch :touch_all_products

  def touch_all_products
    products.update_all(updated_at: Time.current)
  end
end
