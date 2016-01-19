FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@launch.com" }
    first_name 'John'
    last_name 'Lastly'
    password 'SuperPWthatislong'
  end
end
