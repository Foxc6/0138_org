class RemoveRegimenIdFromCustomerRegimens < ActiveRecord::Migration
  def change
    remove_column :customer_regimens, :regimen_id, :integer
  end
end
