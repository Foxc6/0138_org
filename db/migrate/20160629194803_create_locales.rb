class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
    	t.string   :code
    	t.string   :fb_locale
    	t.string   :fb_page
    	t.string   :fb_page_id
    	t.string   :redirect_link
    	t.string   :logo_link
    	t.boolean  :active, default: false
    	t.boolean  :isAPAC, default: false
    	t.string   :tracking_code
    	t.string   :tracking_domain
    	t.string   :twitter_link
    	t.string   :name
    	t.string   :facebook_url
    	t.string   :twitter_url
    	t.string   :youtube_url
    	t.string   :pinterest_url
    	t.string   :instagram_url
    	
    	t.timestamps null: false
    end
  end
end
