class RemoveSkinTypeIdFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :skin_type_id, :references
  end
end
