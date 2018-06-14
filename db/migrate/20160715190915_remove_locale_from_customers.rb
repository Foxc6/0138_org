class RemoveLocaleFromCustomers < ActiveRecord::Migration
  def change
  	remove_reference :customers, :locale, index: true, foreign_key: true
  end
end
