# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    phone_type "MyString"
    phone "MyString"
    contact_id 1
  end
end
