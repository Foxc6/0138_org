class CreateSkinTypes < ActiveRecord::Migration
  def change
    create_table :skin_types do |t|
      t.string :name
      t.references :locale, index: true, foreign_key: true
      t.string :icon_image_file_name
      t.string :icon_image_content_type
      t.integer :icon_image_file_size
      t.datetime :icon_image_updated_at

      t.timestamps null: false
    end
  end
end
