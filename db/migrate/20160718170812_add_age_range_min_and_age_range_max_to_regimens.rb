class AddAgeRangeMinAndAgeRangeMaxToRegimens < ActiveRecord::Migration
  def change
    add_column :regimens, :age_range_min, :integer
    add_column :regimens, :age_range_max, :integer
  end
end
