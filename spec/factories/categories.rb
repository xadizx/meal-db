FactoryBot.define do
  factory :category do
    sequence(:external_id) { |n| n }
    sequence(:name) { |n| "Category #{n}" }
    thumbnail_image_url { Faker::Internet.url }
    description { Faker::Food.description }
  end
end
