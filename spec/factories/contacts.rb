# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"

FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }

    after(:build) do |contact|
      %i( home_phone mobile_phone work_phone ).each do |phone|
        contact.phones << build(:phone, phone_type: phone, contact: contact)
      end
    end
  end
end
