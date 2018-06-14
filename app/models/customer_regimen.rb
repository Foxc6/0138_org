class CustomerRegimen < ActiveRecord::Base
  belongs_to :customer
  belongs_to :guide
  belongs_to :original_regimen, class_name: "Regimen"
  belongs_to :skin_type
  belongs_to :benefit
  belongs_to :age_range
  has_many :customer_regimen_products
  accepts_nested_attributes_for :customer_regimen_products, :allow_destroy => true

  def self.user_scope
    where(Rails.application.config.user_locale_id)
  end

end
