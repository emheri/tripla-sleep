require 'rails_helper'

RSpec.describe 'Api::V1::Follows', type: :request do
  let(:user) { create(:user_with_sleeps) }
  let(:follow) { create(:user_with_sleeps) }

  describe 'POST /create' do
    it 'return a created status' do
      post "/api/v1/users/#{user.id}/follows", params: {
        following_id: follow.id
      }
      expect(response).to have_http_status(:created)
    end

    context 'with invalid parameters and payload' do
      it "user_id doesn't exists" do
        post '/api/v1/users/123/follows'
        expect(response).to have_http_status(:not_found)
      end

      it 'payload is empty' do
        post "/api/v1/users/#{user.id}/follows"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'following_id is null' do
        post "/api/v1/users/#{user.id}/follows", params: { following_id: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'already follow following user' do
        user.follow(follow.id)
        post "/api/v1/users/#{user.id}/follows", params: { following_id: follow.id }
        expect(response).to have_http_status(:bad_request)
      end

      it "following_id doesn't exists" do
        post "/api/v1/users/#{user.id}/follows", params: { following_id: 123 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      user.follow(follow.id)
    end

    it 'return ok status' do
      delete "/api/v1/users/#{user.id}/follows/#{follow.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'following_id not exist in record' do
      delete "/api/v1/users/#{user.id}/follows/123"
      expect(response).to have_http_status(:not_found)
    end

    it 'not follow following_id but record exist' do
      user.unfollow(follow.id)
      delete "/api/v1/users/#{user.id}/follows/#{follow.id}"
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET /following' do
    context 'success response' do
      before do
        user.follow(follow.id)
        get "/api/v1/users/#{user.id}/follows/following"
      end

      it 'return ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an Array' do
        expect(json['data']).to be_instance_of Array
      end

      it 'return sleeps schema' do
        expect(json).to match_response_schema('users')
      end
    end

    it 'user_id not exists' do
      get '/api/v1/users/123/follows/following'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /followers' do
    context 'success response' do
      before do
        user.follow(follow.id)
        get "/api/v1/users/#{follow.id}/follows/followers"
      end

      it 'return ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an Array' do
        expect(json['data']).to be_instance_of Array
      end

      it 'return sleeps schema' do
        expect(json).to match_response_schema('users')
      end
    end

    it 'user_id not exists' do
      get '/api/v1/users/123/follows/followers'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /following/sleep' do
    context 'success response ' do
      before do
        user.follow(follow.id)
        get "/api/v1/users/#{user.id}/follows/following/sleeps"
      end

      it 'return ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an Array' do
        expect(json['data']).to be_instance_of Array
      end

      it 'returns an Array' do
        expect(json['data'].size).to eq(3) # follow has 3 sleep records with different days
      end

      it 'return sleeps schema' do
        expect(json).to match_response_schema('follows')
      end
    end
  end
end
