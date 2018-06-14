class DropTablePrice < ActiveRecord::Migration
  def change
    drop_table :prices
  end
end
