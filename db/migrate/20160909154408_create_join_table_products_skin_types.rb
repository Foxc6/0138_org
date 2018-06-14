class CreateJoinTableProductsSkinTypes < ActiveRecord::Migration
  def change
    create_join_table :products, :skin_types do |t|
      t.index [:product_id, :skin_type_id]
      t.index [:skin_type_id, :product_id]
    end
  end
end
