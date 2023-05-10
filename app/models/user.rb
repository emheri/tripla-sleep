class User < ApplicationRecord
  include Followable
  include Sleepable

  has_many :sleeps, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :follower, class_name: 'Follow', foreign_key: 'following_id',
                      dependent: :destroy, inverse_of: :user
  has_many :following, through: :follows, source: :follower
  has_many :followers, through: :follower, source: :user

  validates :name, presence: true
end
