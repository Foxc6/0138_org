class RenameCustomerProducts < ActiveRecord::Migration
  def change
  	rename_table :customer_products, :customer_regimen_products
  end
end
