module User::Followable
  extend ActiveSupport::Concern

  def follow(id)
    follows.create(following_id: id)
  end

  def unfollow(id)
    follows.find_by(following_id: id)&.destroy
  end

  def following?(id)
    follows.exists?(following_id: id)
  end
end