Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          post '/sleep', to: 'sleeps#sleep'
          post '/wake', to: 'sleeps#wake'
        end
        
        resources :follows, only: [:create] do
          collection do
            delete '/:following_id', to: 'follows#destroy'
          end
        end
      end
    end
  end
end
