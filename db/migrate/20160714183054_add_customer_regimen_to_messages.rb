class AddCustomerRegimenToMessages < ActiveRecord::Migration
  def change
  	add_reference :messages, :customer_regimen, index: true, foreign_key: true
  end
end
