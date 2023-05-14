class UserSerializer
  include JSONAPI::Serializer
  attributes :name

  # sleeps attributes if exists
  attributes :sleep_at, if: proc { |record|
    record.try(:sleep_at)
  } do |record|
    record.sleep_at.to_fs(:long)
  end

  attributes :wake_at, if: proc { |record|
    record.try(:wake_at)
  } do |record|
    record.wake_at&.to_fs(:long)
  end

  # show in hour
  attributes :sleep_duration, if: proc { |record|
    record.try(:sleep_duration)
  } do |record|
    hour = record.sleep_duration / 3600
    minute = (record.sleep_duration / 60) % 60
    "#{hour}.#{minute}".to_f
  end
end
