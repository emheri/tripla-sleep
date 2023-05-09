require 'rails_helper'

# TODO: assert JSON body matcher for response in every request
RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /index" do
    before do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
    end
    
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all users' do
      expect(json['data'].size).to eq(10)
    end
  end

  describe "POST /create" do
    context 'with valid paramenters' do
      let(:user) { build(:user) }

      before do
        post '/api/v1/users', params: {
          user: {
            name: user.name
          }
        }

      end
      it 'return a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'return bad request when pass empty body' do
        post '/api/v1/users'
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return bad request when pass empty name' do
        post '/api/v1/users', params: { user: { name: nil }}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    it 'return http success' do
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'return http not_found' do
      get "/api/v1/users/123"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT/PATCH /update" do
    let(:user) { create(:user) }

    context 'with valid paramenters' do
      it 'return a http success' do
        put "/api/v1/users/#{user.id}", params: { user: { name: 'John doe' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'return bad request when pass empty body' do
        put "/api/v1/users/#{user.id}"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return bad request when pass empty name' do
        put "/api/v1/users/#{user.id}", params: { user: { name: nil }}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    it 'return http success' do
      delete "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'return http not_found' do
      delete "/api/v1/users/123"
      expect(response).to have_http_status(:not_found)
    end
  end
end
