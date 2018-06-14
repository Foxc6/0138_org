class RemoveCustomersRegimenFromMessages < ActiveRecord::Migration
  def change
  	remove_reference :messages, :customers_regimen, index: true, foreign_key: true
  end
end
