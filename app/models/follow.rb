class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: 'User'

  validates :user_id, uniqueness: { scope: :following_id, message: 'Already following' }
end
