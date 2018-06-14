class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string   :name
      t.string   :company
      t.string   :url
      t.text     :meta_description
      t.text     :meta_keywords
      t.string   :seo_title
      t.string   :mail_from_address
      t.boolean  :default,              default: false, null: false
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.integer  :default_country_code
      t.boolean  :is_domestic,          default: true

      t.timestamps null: false
    end
  end
end
