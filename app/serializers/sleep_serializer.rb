class SleepSerializer
  include JSONAPI::Serializer
  attributes :sleep_at do |record|
    record.sleep_at.to_fs(:long)
  end
  attributes :wake_at do |record|
    record.sleep_at.to_fs(:long)
  end
  attributes :duration do |record|
    hour = record.duration / 3600
    minute = (record.duration / 60) % 60
    "#{hour}.#{minute}".to_f
  end
end
