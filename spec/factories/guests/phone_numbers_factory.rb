FactoryBot.define do
  factory :phone_number, class: Guests::PhoneNumber do
    guest { nil }
    number { Faker::PhoneNumber.phone_number }
    phone_type { "primary" }
  end
end
