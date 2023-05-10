require 'rails_helper'

RSpec.describe Sleep, type: :model do
  let(:user) { create(:user) }

  it 'should set the duration' do
    sleep_time = Time.current
    wake_time = sleep_time + 8.hours
    sleeping_time = (wake_time - sleep_time).to_i.abs
    sleeping = user.sleeps.create(sleep_at: sleep_time)
    expect do 
      sleeping.update(wake_at: wake_time)
    end.to change(sleeping, :duration).from(0).to(sleeping_time)
  end

  it 'should save wake_at' do
    sleeping = user.sleep!
    expect(sleeping.wake_at.nil?).to be true

    sleeping.wake!
    expect(sleeping.wake_at.present?).to be true
  end
  
  
  context 'validation' do
    it 'require sleep_at if want to set wake_at' do
      expect(user.sleeps.create(wake_at: Time.current)).to_not be_valid
    end
  end
end
