class RemoveProductsAndSkinTypesFromSkinTypeProducts < ActiveRecord::Migration
  def change
  	remove_reference :skin_type_products, :product, index: true, foreign_key: true
  	remove_reference :skin_type_products, :skin_type, index: true, foreign_key: true
  end
end
