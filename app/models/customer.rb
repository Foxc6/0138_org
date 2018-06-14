class Customer < ActiveRecord::Base
	belongs_to :locale
	has_many :customer_regimens
	has_many :customer_regimen_products, through: :customer_regimens

  #validates :email, :presence => true, :uniqueness => true
  accepts_nested_attributes_for :customer_regimens, :allow_destroy => true
  after_create :assign_locale


  def self.user_scope
    where(locale_id: Rails.application.config.user_locale_id)
  end

  def no_customer(attributes)
    attributes[:customer_id].blank?
  end

  private

  def assign_locale
    unless self.locale_id.present?
      self.locale_id = Rails.application.config.user_locale_id
      self.save!
    end
  end

end
