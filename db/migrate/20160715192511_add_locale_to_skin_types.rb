class AddLocaleToSkinTypes < ActiveRecord::Migration
  def change
  	add_reference :skin_types, :locale, index: true
  end
end
