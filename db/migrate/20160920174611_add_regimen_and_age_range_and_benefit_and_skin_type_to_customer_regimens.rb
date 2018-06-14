class AddRegimenAndAgeRangeAndBenefitAndSkinTypeToCustomerRegimens < ActiveRecord::Migration
  def change
  	add_reference :customer_regimens, :original_regimen, references: :regimens
  	add_reference :customer_regimens, :age_range, index: true
  	add_reference :customer_regimens, :benefit, index: true
  	add_reference :customer_regimens, :skin_type, index: true
  end
end
