require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should create user' do
    user = create(:user)
    expect(user).to  be_valid
  end

  context 'validation' do
    it 'require the presence of name' do
      expect(User.create(name: nil)).to_not be_valid
    end
  end

  context 'sleeps relation' do
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
end
