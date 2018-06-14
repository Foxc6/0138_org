class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.string :size
      t.decimal :price, :precision => 10, :scale => 2, :default => 0.00
      t.integer :position
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
