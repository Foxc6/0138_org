class RemoveCustomersAndRegimensFromCustomerRegimens < ActiveRecord::Migration
  def change
  	remove_reference :customer_regimens, :customer, index: true, foreign_key: true
  	remove_reference :customer_regimens, :regimen, index: true, foreign_key: true
  end
end
