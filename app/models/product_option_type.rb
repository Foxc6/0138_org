class ProductOptionType < ActiveRecord::Base
  belongs_to :product, class_name: 'Product', inverse_of: :product_option_types
  belongs_to :option_type, class_name: 'OptionType', inverse_of: :product_option_types
end
