class User < ApplicationRecord
  has_many :sleeps

  validates :name, presence: true

  def sleeping
    sleeps.where.not(sleep_at: nil).where(wake_at: nil).first
  end
  
  def sleeping?
    sleeps.where.not(sleep_at: nil).where(wake_at: nil).exists?
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
