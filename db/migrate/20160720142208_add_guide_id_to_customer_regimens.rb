class AddGuideIdToCustomerRegimens < ActiveRecord::Migration
  def change
    add_reference :customer_regimens, :guide, index: true, foreign_key: true
  end
end
