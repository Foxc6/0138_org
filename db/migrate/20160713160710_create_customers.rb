class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :newsletter_optin
      t.boolean :email_optin

      t.timestamps null: false
    end
  end
end
