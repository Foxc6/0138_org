class RemoveLocaleAndProductCategoriesFromProducts < ActiveRecord::Migration
  def change
  	remove_reference :products, :locale, index: true, foreign_key: true
  	remove_reference :products, :product_category, index: true, foreign_key: true
  end
end
