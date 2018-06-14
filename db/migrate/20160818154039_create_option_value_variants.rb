class CreateOptionValueVariants < ActiveRecord::Migration
  def change
    create_table :option_values_variants do |t|
      t.references :option_value, index: true, foreign_key: true
      t.references :variant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
