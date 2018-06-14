class AddCustomerRegimenToCustomerRegimenProducts < ActiveRecord::Migration
  def change
  	add_reference :customer_regimen_products, :customer_regimen, index: true
  end
end
