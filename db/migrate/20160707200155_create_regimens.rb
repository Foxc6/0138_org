class CreateRegimens < ActiveRecord::Migration
  def change
    create_table :regimens do |t|
      t.string :name
      t.references :age_range, index: true, foreign_key: true
      t.references :gender, index: true, foreign_key: true
      t.references :skin_type, index: true, foreign_key: true
      t.references :benefit, index: true, foreign_key: true
      t.references :locale, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
