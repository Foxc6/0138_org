class Regimen < ActiveRecord::Base
  belongs_to :age_range
  belongs_to :gender
  belongs_to :benefit
  belongs_to :locale

  has_many :customer_regimens


  has_and_belongs_to_many :skin_types
  has_and_belongs_to_many :products

  after_create :assign_locale
  validates :name, presence: true


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
