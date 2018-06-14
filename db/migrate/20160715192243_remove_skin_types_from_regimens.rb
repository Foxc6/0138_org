class RemoveSkinTypesFromRegimens < ActiveRecord::Migration
  def change
  	remove_reference :regimens, :skin_type, index: true, foreign_key: true
  end
end
