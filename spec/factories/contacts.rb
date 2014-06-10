# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    firstname "Tom"
    lastname "Hanks"
    # email "MyString"
    sequence(:email) {|n| "TomHanks#{m}@oscar.com"}
  end
end
