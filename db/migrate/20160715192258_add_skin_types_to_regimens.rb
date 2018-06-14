class AddSkinTypesToRegimens < ActiveRecord::Migration
  def change
  	add_reference :regimens, :skin_type, index: true
  end
end
