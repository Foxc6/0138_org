class AddLocaleToAgeRanges < ActiveRecord::Migration
  def change
  	add_reference :age_ranges, :locale, index: true
  end
end
