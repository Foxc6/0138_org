FactoryGirl.define do
  factory :message do
    subject "MyString"
    to "MyString"
    body "MyText"
    message_type "MyString"
    customer_regimen nil
    template "MyString"
  end
end
