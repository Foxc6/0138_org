class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :sku
      t.decimal :weight, :precision => 10, :scale => 0
      t.decimal :height, :precision => 10, :scale => 0
      t.decimal :width, :precision => 10, :scale => 0
      t.decimal :depth, :precision => 10, :scale => 0
      t.boolean :is_master, :default => false
      t.references :product, index: true, foreign_key: true
      t.decimal :cost_price, :precision => 10, :scale => 2, :default => 0.00
      t.string :cost_currency
      t.string :position
      t.string :track_inventory
      t.integer :tax_category_id
      t.integer :stock_item_count

      t.timestamps null: false
    end
  end
end
