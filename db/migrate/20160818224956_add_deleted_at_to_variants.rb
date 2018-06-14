class AddDeletedAtToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :deleted_at, :date
  end
end
