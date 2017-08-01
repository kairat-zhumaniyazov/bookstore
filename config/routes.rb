Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :publisher, only: [] do
        get '/in_stores', to: 'publishers#in_stores', on: :member
      end
    end
  end
end
