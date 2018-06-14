class CreateSkinTypeRegimens < ActiveRecord::Migration
  def change
    create_table :skin_type_regimens do |t|
      t.references :skin_type, index: true
      t.references :regimen, index: true

      t.timestamps null: false
    end
  end
end
