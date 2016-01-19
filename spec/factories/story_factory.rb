FactoryGirl.define do
  factory :story do
    sequence(:title) { |n| "Life Of Pi#{n}" }
    sequence(:body) { |n| "I suppose in the end,
      the whole of life becomes an act of letting go,
      but what always hurts the most is not taking
      a moment to say goodbye. At least just #{n} times " }
    association :creator, factory: :user
  end
end
