class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :variant, index: true, foreign_key: true
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0.00
      t.string :currency

      t.timestamps null: false
    end
  end
end
