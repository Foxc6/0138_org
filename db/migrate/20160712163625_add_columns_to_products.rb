class AddColumnsToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :size, :string
  	add_column :products, :code, :string
  	add_column :products, :upc, :string
  	add_column :products, :collection, :string
  end
end
