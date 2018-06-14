class RemovePriceAndSizeAndCodeAndUpcFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :price, :decimal
  	remove_column :products, :code, :string
  	remove_column :products, :size, :string
  	remove_column :products, :upc, :string
  end
end
