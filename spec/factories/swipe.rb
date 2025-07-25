FactoryBot.define do
  factory :swipe do
    user { create(:user) }
    meal { create(:meal) }
    preference { Swipe.preferences.values.sample }
  end
end
