Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :publishers, except: [:new, :edit] do
        resources :books, only: [:index, :show, :create], controller: 'publisher_books'
      end
      resources :books, except: [:new, :edit]

      resources :stores, except: [:new, :edit] do
        get '/publisher_books', to: 'stores#publisher_books', on: :collection
        get '/books_sold', to: 'stores#books_sold', on: :member
        post '/add_book', to: 'stores#add_book', on: :member
      end
    end
  end
end
