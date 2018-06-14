class ProductsRegimen < ActiveRecord::Base
  belongs_to :regimen
  belongs_to :product

  def self.user_scope
    where(locale_id: Rails.application.config.user_locale_id)
  end
end
