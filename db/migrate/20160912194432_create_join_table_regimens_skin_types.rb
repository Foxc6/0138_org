class CreateJoinTableRegimensSkinTypes < ActiveRecord::Migration
  def change
    create_join_table :regimens, :skin_types do |t|
      t.index [:regimen_id, :skin_type_id]
      t.index [:skin_type_id, :regimen_id]
    end
  end
end
