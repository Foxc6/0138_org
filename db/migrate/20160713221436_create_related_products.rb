class CreateRelatedProducts < ActiveRecord::Migration
  def change
    create_table :related_products do |t|
      t.integer :relatable_id
      t.integer :related_to_id

      t.timestamps null: false
    end
  end
end
