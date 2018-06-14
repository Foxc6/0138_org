class AddCustomerRegimensToMessages < ActiveRecord::Migration
  def change
  	add_reference :messages, :customer_regimen, index: true
  end
end
