require 'rails_helper'

RSpec.describe "Api::V1::Follows", type: :request do
  let(:user) { create(:user) }
  let(:follow) { create(:user) }

  describe "POST /create" do
    it 'return a created status' do
      post "/api/v1/users/#{user.id}/follows", params: {
        following_id: follow.id
      }
      expect(response).to have_http_status(:created)
    end

    context 'with invalid parameters and payload' do
      it "user_id doesn't exists" do
        post "/api/v1/users/123/follows"
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

  describe "DELETE /destroy" do
    before do
      user.follow(follow.id)
    end

    it "return ok status" do
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

  describe "GET /following" do
    it "return ok status" do
      get "/api/v1/users/#{user.id}/follows/following"
      expect(response).to have_http_status(:ok)
    end
    
    it 'user_id not exists' do
      get "/api/v1/users/123/follows/following"
      expect(response).to have_http_status(:not_found) 
    end
  end
  
  describe "GET /followers" do
    it "return ok status" do
      get "/api/v1/users/#{user.id}/follows/followers"
      expect(response).to have_http_status(:ok)
    end
    
    it 'user_id not exists' do
      get "/api/v1/users/123/follows/followers"
      expect(response).to have_http_status(:not_found) 
    end
  end
end
