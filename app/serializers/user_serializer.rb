class UserSerializer
  include JSONAPI::Serializer
  attributes :name

  # show in hour
  attributes :sleep_duration, if: proc { |record|
    record.try(:sleep_duration)
  } do |record|
    hour = record.sleep_duration / 3600
    minute = (record.sleep_duration / 60) % 60
    "#{hour}.#{minute}".to_f
  end
end
