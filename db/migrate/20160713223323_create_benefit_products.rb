class CreateBenefitProducts < ActiveRecord::Migration
  def change
    create_table :benefit_products do |t|
      t.references :benefit, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
