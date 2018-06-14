class AddIsMaleOnlyToProductCategories < ActiveRecord::Migration
  def change
    add_column :product_categories, :is_male_only, :boolean
  end
end
