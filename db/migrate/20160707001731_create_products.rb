class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :product_category, index: true, foreign_key: true
      t.string :franchise_name
      t.string :product_name
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.boolean :is_new
      t.string :active_ingredient
      t.text :description
      t.integer :position
      t.references :locale, index: true, foreign_key: true
      t.string :seo_url
      t.boolean :active

      t.timestamps null: false
    end
  end
end