class AddLocaleIdToGuides < ActiveRecord::Migration
  def change
  	add_reference :guides, :locale, index: true
  end
end
