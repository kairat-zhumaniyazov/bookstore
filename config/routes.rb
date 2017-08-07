Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :publishers, except: :new
      resources :books, except: :new

      resources :stores, except: :new do
        get '/publisher_books', to: 'stores#publisher_books', on: :collection
        get '/books_sold', to: 'stores#books_sold', on: :member
      end
    end
  end
end
