class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :locale_id, :integer
  	remove_column :users, :role_id, :integer
  end
end
