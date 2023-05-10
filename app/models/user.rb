class User < ApplicationRecord
  include Followable
  include Sleepable

  has_many :sleeps, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followed, class_name: 'Follow', foreign_key: 'following_id',
                      dependent: :destroy, inverse_of: :following
  has_many :following, through: :follows, source: :following
  has_many :followers, through: :followed, source: :user

  validates :name, presence: true
end
