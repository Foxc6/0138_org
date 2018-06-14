class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :to
      t.text :body
      t.string :message_type
      t.references :customers_regimen, index: true, foreign_key: true
      t.string :template

      t.timestamps null: false
    end
  end
end
