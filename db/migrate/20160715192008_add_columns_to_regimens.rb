class AddColumnsToRegimens < ActiveRecord::Migration
  def change
  	add_reference :regimens, :age_range, index: true
  	add_reference :regimens, :benefit, index: true
  	add_reference :regimens, :gender, index: true
  	add_reference :regimens, :locale, index: true
  end
end
