class AddUpcToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :upc, :integer
  end
end
