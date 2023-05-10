require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should create user' do
    user = create(:user)
    expect(user).to be_valid
  end

  context 'validation' do
    it 'require the presence of name' do
      expect(User.create(name: nil)).to_not be_valid
    end
  end

  context 'sleepable' do
    let(:user) { create(:user) }

    it 'should awake' do
      expect(user.awake?).to be true
    end

    it 'should sleep' do
      expect(user.sleeps.count).to eq(0)
      user.sleep!
      expect(user.sleeping?).to be true
      expect(user.sleeps.count).to eq(1)
    end
  end

  context 'followable' do
    let(:user) { create(:user) }
    let(:follow) { create(:user) }

    it 'should follow' do
      expect do
        user.follow(follow.id)
      end.to change { user.following?(follow.id) }.from(false).to(true)
                                                  .and change { user.follows.count }.from(0).to(1)
    end

    it 'should unfollow' do
      user.follow(follow.id)
      expect do
        user.unfollow(follow.id)
      end.to change { user.following?(follow.id) }.from(true).to(false)
                                                  .and change { user.follows.count }.from(1).to(0)
    end
  end
end
