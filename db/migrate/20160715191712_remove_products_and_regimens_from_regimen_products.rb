class RemoveProductsAndRegimensFromRegimenProducts < ActiveRecord::Migration
  def change
  	remove_reference :regimen_products, :product, index: true, foreign_key: true
  	remove_reference :regimen_products, :regimen, index: true, foreign_key: true
  end
end
