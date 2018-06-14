class RemoveCustomersAndProductsFromCustomerRegimenProducts < ActiveRecord::Migration
  def change
  	remove_reference :customer_regimen_products, :customer, index: true, foreign_key: true
  	remove_reference :customer_regimen_products, :product, index: true, foreign_key: true
  end
end
