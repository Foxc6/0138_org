class AddProductsAndRegimensToRegimenProducts < ActiveRecord::Migration
  def change
  	add_reference :regimen_products, :product, index: true
  	add_reference :regimen_products, :regimen, index: true
  end
end
