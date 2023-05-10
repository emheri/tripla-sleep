module User::Sleepable
  extend ActiveSupport::Concern

  def sleeping
    sleeps.where.not(sleep_at: nil).where(wake_at: nil).first
  end

  def sleeping?
    sleeps.where.not(sleep_at: nil).exists?(wake_at: nil)
  end

  def awake?
    !sleeping?
  end

  def sleep!
    sleeps.create!(sleep_at: Time.current)
  end

  def wake!
    sleeping.wake!
  end
end