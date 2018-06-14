class CreateAgeRanges < ActiveRecord::Migration
  def change
    create_table :age_ranges do |t|
      t.string :name
      t.references :locale, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
