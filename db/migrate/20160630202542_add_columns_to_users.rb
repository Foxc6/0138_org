class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_reference :users, :locale, index: true
  	add_reference :users, :role, index: true
  end
end
