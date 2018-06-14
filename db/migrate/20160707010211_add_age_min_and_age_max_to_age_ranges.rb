class AddAgeMinAndAgeMaxToAgeRanges < ActiveRecord::Migration
  def change
    add_column :age_ranges, :age_min, :integer
  	add_column :age_ranges, :age_max, :integer
  end
end
