require 'rails_helper'

RSpec.describe 'Api::V1::Sleeps', type: :request do
  let(:user) { create(:user_with_sleeps) }

  describe 'GET /index' do
    before do
      get "/api/v1/users/#{user.id}/sleeps"
    end

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns users size' do
      expect(json['data'].size).to eq(3)
    end

    it 'returns an Array' do
      expect(json['data']).to be_instance_of Array
    end

    it 'return sleeps schema' do
      expect(json).to match_response_schema('sleeps')
    end
  end

  describe 'POST /sleep' do
    it "return http success when user don't sleep" do
      expect(user.awake?).to be true
      post "/api/v1/users/#{user.id}/sleeps/sleep"

      expect(response).to have_http_status(:success)
    end

    it 'return http unprocessable_entity when user still sleep' do
      user.sleep!
      expect(user.sleeping?).to be true
      post "/api/v1/users/#{user.id}/sleeps/sleep"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /wake' do
    it 'return http success when user sleep' do
      user.sleep!
      expect(user.sleeping?).to be true
      post "/api/v1/users/#{user.id}/sleeps/wake"

      expect(response).to have_http_status(:success)
    end

    it "return http unprocessable_entity when user hasn't sleep" do
      expect(user.awake?).to be true
      post "/api/v1/users/#{user.id}/sleeps/wake"

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
