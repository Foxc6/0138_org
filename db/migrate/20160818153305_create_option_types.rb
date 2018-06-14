class CreateOptionTypes < ActiveRecord::Migration
  def change
    create_table :option_types do |t|
      t.string :name
      t.string :presentation

      t.timestamps null: false
    end
  end
end
