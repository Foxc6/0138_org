class RemoveCustomerRegimensFromMessages < ActiveRecord::Migration
  def change
  	remove_reference :messages, :customer_regimen, index: true, foreign_key: true
  end
end
