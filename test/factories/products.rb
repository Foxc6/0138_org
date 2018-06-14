require 'faker'
FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Commerce.product_name}
    f.franchise_name { Faker::Commerce.product_name}
    is_new false
    f.active_ingredient { Faker::Lorem.words(2)}
    f.description { Faker::Lorem.sentence(3) }
    f.position 1
    f.seo_url "test_url"
    f.active false
  end
end

