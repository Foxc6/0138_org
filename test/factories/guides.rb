require 'faker'
FactoryGirl.define do
  factory :guide do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email {Faker::Internet.free_email}
    f.username {Faker::Internet.user_name}
  end
end
