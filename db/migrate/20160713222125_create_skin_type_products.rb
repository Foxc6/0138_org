class CreateSkinTypeProducts < ActiveRecord::Migration
  def change
    create_table :skin_type_products do |t|
      t.references :skin_type, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
