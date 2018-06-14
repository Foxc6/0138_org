class RemoveColumnsFromRegimens < ActiveRecord::Migration
  def change
  	remove_reference :regimens, :age_range, index: true, foreign_key: true
  	remove_reference :regimens, :benefit, index: true, foreign_key: true
  	remove_reference :regimens, :gender, index: true, foreign_key: true
  	remove_reference :regimens, :locale, index: true, foreign_key: true
  end
end
