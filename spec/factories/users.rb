FactoryBot.define do
  factory :user do
    name { Faker::Name.name }

    transient do
      sleep_count { 3 }
    end

    factory :user_with_sleeps do
      after(:create) do |user, evaluator|
        evaluator.sleep_count.downto(1).each do |day|
          create(:sleep, user:, sleep_day: day)
        end
      end
    end

    factory :user_follow_other_user do
      after(:create) do |user, _|
        following = create(:user_with_sleeps)
        create(:follow, user:, following:)
      end
    end
  end
end
