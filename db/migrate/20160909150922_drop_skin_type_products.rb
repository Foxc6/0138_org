class DropSkinTypeProducts < ActiveRecord::Migration
  def change
    drop_table :skin_type_products
  end
end
