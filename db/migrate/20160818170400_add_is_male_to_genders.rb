class AddIsMaleToGenders < ActiveRecord::Migration
  def change
    add_column :genders, :is_male, :boolean
  end
end
