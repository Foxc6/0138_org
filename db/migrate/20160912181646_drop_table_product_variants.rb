class DropTableProductVariants < ActiveRecord::Migration
  def change
  	drop_table :product_variants
  end
end
