class CustomerRegimenProduct < ActiveRecord::Base

	belongs_to :product
  belongs_to :customer_regimen


  def name
    product = Product.find(self.id)
    product.name
  end

  rails_admin do
    object_label_method :name
  end
end
