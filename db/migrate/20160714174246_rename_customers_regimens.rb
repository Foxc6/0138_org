class RenameCustomersRegimens < ActiveRecord::Migration
  def change
  	rename_table :customers_regimens, :customer_regimens
  end
end
