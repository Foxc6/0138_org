class AddLocaleToBenefits < ActiveRecord::Migration
  def change
  	add_reference :benefits, :locale, index: true
  end
end
