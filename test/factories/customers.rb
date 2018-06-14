require 'faker'
Rails.application.config.user_locale_id = 1
FactoryGirl.define do
  factory :customer do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email {Faker::Internet.free_email}
  end
end
