class AgeRange < ActiveRecord::Base
  belongs_to :locale
  has_many :customer_regimens
  after_create :assign_locale


  def self.user_scope
    where(locale_id: Rails.application.config.user_locale_id)
  end

  private

  def assign_locale
    unless self.locale_id.present?
      self.locale_id = Rails.application.config.user_locale_id
      self.save!
    end
  end

end
