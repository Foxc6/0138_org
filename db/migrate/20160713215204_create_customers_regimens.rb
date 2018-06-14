class CreateCustomersRegimens < ActiveRecord::Migration
  def change
    create_table :customers_regimens do |t|
      t.references :customer, index: true, foreign_key: true
      t.references :regimen, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
