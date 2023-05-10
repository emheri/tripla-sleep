class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: "User", foreign_key: 'following_id'

  validates_uniqueness_of :user_id, scope: :following_id, message: "Already following"
end
