class RemoveSkinTypeIdFromRegimens < ActiveRecord::Migration
  def change
  	remove_column :regimens, :skin_type_id, :references
  end
end
