class AddBenefitAndProductToBenefitProducts < ActiveRecord::Migration
  def change
  	add_reference :benefit_products, :benefit, index: true
  	add_reference :benefit_products, :product, index: true
  end
end
