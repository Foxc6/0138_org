class AddCustomersAndRegimensToCustomerRegimens < ActiveRecord::Migration
  def change
  	add_reference :customer_regimens, :customer, index: true
  	add_reference :customer_regimens, :regimen, index: true
  end
end
