class DropTableRelatedProducts < ActiveRecord::Migration
  def change
    drop_table :related_products
  end
end
