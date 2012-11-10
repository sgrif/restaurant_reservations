# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    email "admin@example.com"
    password "password"
    password_confirmation "password"
    name "MyString"
    count_tables 1
    reservation_length 15
  end
end
