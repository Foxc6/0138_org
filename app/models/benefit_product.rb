class BenefitProduct < ActiveRecord::Base
  belongs_to :benefit
  belongs_to :product


end
