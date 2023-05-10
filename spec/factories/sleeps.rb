FactoryBot.define do
  sleep_at = 6.days.ago
  wake_at = sleep_at + 8.hours
  factory :sleep do
    association :user
    sleep_at { sleep_at }
    wake_at { wake_at }
  end
end
