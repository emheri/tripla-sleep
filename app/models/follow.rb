class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'User', foreign_key: 'following_id', inverse_of: :follow

  validates :user_id, uniqueness: { scope: :following_id, message: 'Already following' }
end
