FactoryBot.define do
  factory :sleep do
    association :user

    transient do
      sleep_day { 3 }
      sleep_time { sleep_day.days.ago }
      wake_time { sleep_time + 8.hours }
    end

    sleep_at { sleep_time }
    wake_at { wake_time }
    duration { (wake_time - sleep_time).to_i.abs }
  end
end
