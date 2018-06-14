class SkinType < ActiveRecord::Base
  belongs_to :locale

  has_many :products_skin_types
  has_many :regimens_skin_types
  has_many :customer_regimens

  after_create :assign_locale

  has_attached_file :icon_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon_image, :content_type => /\Aimage\/.*\Z/
  attr_accessor :delete_icon_image
  before_validation { self.icon_image.clear if self.delete_icon_image == '1' }

  has_attached_file :icon_image_rollover, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon_image_rollover, :content_type => /\Aimage\/.*\Z/
  attr_accessor :delete_icon_image_rollover
  before_validation { self.icon_image_rollover.clear if self.delete_icon_image_rollover == '1' }

  rails_admin do
    object_label_method :name
  end

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
