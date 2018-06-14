FactoryGirl.define do
  factory :related_product do
    relatable_id 1
    related_to_id 1
  end
end
