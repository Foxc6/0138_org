class AddLocaleAndProductCategoriesToProducts < ActiveRecord::Migration
  def change
  	add_reference :products, :locale, index: true
  	add_reference :products, :product_category, index: true
  end
end
