class RemoveCustomerIdFromCustomerRegimenProducts < ActiveRecord::Migration
  def change
    remove_column :customer_regimen_products, :customer_id, :integer
  end
end
