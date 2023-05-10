require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user) { create(:user) }
  let(:follow) { create(:user) }

  it 'should create follow' do
    expect(user.follow(follow.id)).to be_valid
  end

  it "can't follow already following" do
    user.follow(follow.id)
    expect(user.follow(follow.id)).to_not be_valid
  end
end
