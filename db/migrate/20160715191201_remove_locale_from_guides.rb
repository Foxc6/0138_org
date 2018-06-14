class RemoveLocaleFromGuides < ActiveRecord::Migration
  def change
  	remove_reference :guides, :locale, index: true, foreign_key: true
  end
end
