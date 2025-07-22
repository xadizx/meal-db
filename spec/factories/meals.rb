FactoryBot.define do
  factory :meal do
    sequence(:external_id) { |n| "meal_#{n}" }
    sequence(:name) { |n| "Meal #{n}" }
    thumbnail_image_url { Faker::Internet.url }
    tags { Faker::Lorem.words(number: 3).join(", ") }
    instructions { Faker::Food.description }
    area { ["American", "British", "Polish"].sample }
    category { create(:category) }
  end
end
