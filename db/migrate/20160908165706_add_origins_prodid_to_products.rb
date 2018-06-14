class AddOriginsProdidToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :origins_prodid, :integer
  end
end
