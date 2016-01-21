FactoryGirl.define do
  factory :comment do
    sequence(:body) { |n| "Some great comment that user#{n} left"}
    association :creator, factory: :user
    association :story, factory: :story
  end
end
