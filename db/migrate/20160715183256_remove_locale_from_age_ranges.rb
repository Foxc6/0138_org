class RemoveLocaleFromAgeRanges < ActiveRecord::Migration
  def change
  	remove_reference :age_ranges, :locale, index: true, foreign_key: true
  end
end
