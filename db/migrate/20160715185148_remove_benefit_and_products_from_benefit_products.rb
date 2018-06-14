class RemoveBenefitAndProductsFromBenefitProducts < ActiveRecord::Migration
  def change
  	remove_reference :benefit_products, :benefit, index: true, foreign_key: true
  	remove_reference :benefit_products, :product, index: true, foreign_key: true
  end
end
