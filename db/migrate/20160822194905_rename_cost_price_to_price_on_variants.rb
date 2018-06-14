class RenameCostPriceToPriceOnVariants < ActiveRecord::Migration
  def change
    rename_column :variants, :cost_price, :price
  end
end
