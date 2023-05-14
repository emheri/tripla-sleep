FactoryBot.define do
  factory :follow do
    user
    following { association :user }
  end
end
