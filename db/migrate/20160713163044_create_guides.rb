class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username

      t.timestamps null: false
    end
  end
end
