require 'rails_helper'

RSpec.describe 'Api::V1::Sleeps', type: :request do
  let(:user) { create(:user) }

  describe 'POST /sleep' do
    it "return http success when user don't sleep" do
      expect(user.awake?).to be true
      post "/api/v1/users/#{user.id}/sleep"

      expect(response).to have_http_status(:success)
    end

    it 'return http unprocessable_entity when user still sleep' do
      user.sleep!
      expect(user.sleeping?).to be true
      post "/api/v1/users/#{user.id}/sleep"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /wake' do
    it 'return http success when user sleep' do
      user.sleep!
      expect(user.sleeping?).to be true
      post "/api/v1/users/#{user.id}/wake"

      expect(response).to have_http_status(:success)
    end

    it "return http unprocessable_entity when user hasn't sleep" do
      expect(user.awake?).to be true
      post "/api/v1/users/#{user.id}/wake"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
