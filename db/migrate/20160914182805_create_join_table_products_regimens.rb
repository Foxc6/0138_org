class CreateJoinTableProductsRegimens < ActiveRecord::Migration
  def change
    create_join_table :products, :regimens do |t|
      t.index [:product_id, :regimen_id]
      t.index [:regimen_id, :product_id]
    end
  end
end
