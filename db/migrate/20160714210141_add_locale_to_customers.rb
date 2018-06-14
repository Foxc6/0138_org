class AddLocaleToCustomers < ActiveRecord::Migration
  def change
  	add_reference :customers, :locale, index: true, foreign_key: true
  end
end
