class ProductsSkinType < ActiveRecord::Base
	belongs_to :skin_type
	belongs_to :product

  rails_admin do
    object_label_method :name
  end

  def name
    name = SkinType.find(self.skin_type_id).name
  end
end
