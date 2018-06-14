require 'faker'
  age_range_id = AgeRange.first.id
  benefit_id = Benefit.first.id
  gender_id = Gender.first.id
FactoryGirl.define do
  factory :regimen do |f|
    f.name { Faker::Commerce.product_name}
    f.age_range_id age_range_id
    f.benefit_id benefit_id
    f.gender_id gender_id
    f.age_range_min 18
    f.age_range_max 55
  end
end

