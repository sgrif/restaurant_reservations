# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation do
    starts_at "2012-11-04 15:37:30"
    ends_at "2012-11-04 15:37:30"
    name "MyString"
    restaurant nil
    confirmation_token "MyString"
  end
end
