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
end
