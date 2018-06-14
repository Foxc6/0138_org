class AddProductsAndSkinTypesToSkinTypeProducts < ActiveRecord::Migration
  def change
  	add_reference :skin_type_products, :product, index: true
  	add_reference :skin_type_products, :skin_type, index: true
  end
end
