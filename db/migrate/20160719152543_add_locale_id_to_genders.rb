class AddLocaleIdToGenders < ActiveRecord::Migration
  def change
    add_reference :genders, :locale, index: true
  end
end
