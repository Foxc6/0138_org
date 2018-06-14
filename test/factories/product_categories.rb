require 'faker'
FactoryGirl.define do
  factory :product_category do |f|
    f.name { Faker::Commerce.product_name}
    f.slug { Faker::Internet.slug }
    f.position { Faker::Number.between(from = 1, to = 99) }
  end
end
