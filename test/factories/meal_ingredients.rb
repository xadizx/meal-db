FactoryBot.define do
  factory :meal_ingredient do
    meal { create(:meal) }
    name { Faker::Food.ingredient }
    measurement { Faker::Food.measurement }
  end
end
