FactoryGirl.define do
  factory :variant do
    code "MyString"
    weight "9.99"
    height "9.99"
    width "9.99"
    depth "9.99"
    is_master false
    product nil
    price "9.99"
    cost_currency "MyString"
    position "MyString"
    track_inventory "MyString"
    tax_category_id 1
    stock_item_count 1
  end
end
