class AddLocaleIdToPreferences < ActiveRecord::Migration
  def change
  	add_reference :preferences, :locale, index: true
  end
end
