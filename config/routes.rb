Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users

  resources :addresses do
    collection do
      get :find
    end
  end

  resources :tokens do
    collection do
      post :refresh
    end
  end
end
