class AddLocaleToGuides < ActiveRecord::Migration
  def change
  	add_reference :guides, :locale, index: true, foreign_key: true
  end
end
