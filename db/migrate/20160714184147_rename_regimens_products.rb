class RenameRegimensProducts < ActiveRecord::Migration
  def change
  	rename_table :regimens_products, :regimen_products
  end
end
