class Sleep < ApplicationRecord
  belongs_to :user

  before_update :set_duration

  validate :must_sleep

  def wake!
    update(wake_at: Time.current)  
  end

  private

  # set duration in seconds
  def set_duration
    return unless will_save_change_to_wake_at?

    self.duration = (wake_at - sleep_at).to_i.abs
  end

  def must_sleep
    return unless will_save_change_to_wake_at?

    errors.add(:start_at, 'start_at must be presence') if sleep_at.nil?
  end
end
