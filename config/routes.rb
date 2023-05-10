Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :follows, only: [:create] do
          collection do
            delete '/:following_id', to: 'follows#destroy'
            get :following
            get :followers
          end
        end

        resources :sleeps, only: [:index] do
          collection do
            post :sleep
            post :wake
          end
        end
      end
    end
  end
end
