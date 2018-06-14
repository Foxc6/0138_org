class AddLocaleIdToCustomers < ActiveRecord::Migration
  def change
  	add_reference :customers, :locale, index: true
  end
end
