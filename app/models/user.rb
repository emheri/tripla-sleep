class User < ApplicationRecord
  include Followable
  include Sleepable

  has_many :sleeps
  has_many :follows
  has_many :follower, class_name: 'Follow', foreign_key: 'following_id'
  has_many :following, through: :follows, source: :follower
  has_many :followers, through: :follower, source: :user

  validates :name, presence: true
end
