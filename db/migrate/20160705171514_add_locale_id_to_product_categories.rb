class AddLocaleIdToProductCategories < ActiveRecord::Migration
  def change
  	add_reference :product_categories, :locale, index: true
  end
end
