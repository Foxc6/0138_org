class RegimensSkinType < ActiveRecord::Base
  belongs_to :regimen
  belongs_to :skin_type

  rails_admin do
    object_label_method :name
  end

  def name
    name = SkinType.find(self.skin_type_id).name
  end
end
