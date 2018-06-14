class RemoveLocaleFromBenefits < ActiveRecord::Migration
  def change
  	remove_reference :benefits, :locale, index: true, foreign_key: true
  end
end
