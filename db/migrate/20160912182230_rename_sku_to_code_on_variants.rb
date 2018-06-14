class RenameSkuToCodeOnVariants < ActiveRecord::Migration
  def change
  	rename_column :variants, :sku, :code
  end
end
