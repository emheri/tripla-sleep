FactoryBot.define do
  factory :sleep do
    sleep_at { "2023-05-09 22:15:39" }
    wake_at { "2023-05-09 22:15:39" }
    duration { 1.5 }
  end
end
