class CreateRegimensProducts < ActiveRecord::Migration
  def change
    create_table :regimens_products do |t|
      t.references :regimen, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
