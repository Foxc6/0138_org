class DropRegimenProducts < ActiveRecord::Migration
  def change
    drop_table :regimen_products
  end
end
