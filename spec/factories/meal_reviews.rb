FactoryBot.define do
  factory :meal_review do
    user
    meal
    rating { rand(1..5) }
  end
end
