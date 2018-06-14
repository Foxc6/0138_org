class RemoveLocalesFromSkinTypes < ActiveRecord::Migration
  def change
  	remove_reference :skin_types, :locale, index: true, foreign_key: true
  end
end
