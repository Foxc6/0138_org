class AddCustomersAndProductsToCustomerRegimenProducts < ActiveRecord::Migration
  def change
  	add_reference :customer_regimen_products, :customer, index: true
  	add_reference :customer_regimen_products, :product, index: true
  end
end
