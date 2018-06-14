class AddSkinTypeToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :skin_type, index: true
  end
end
