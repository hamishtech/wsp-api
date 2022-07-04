Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post '/auth/login/google', to: 'authentication#login_google'
      get '/auth/authenticate', to: 'authentication#authenticate_user'
      get '/auth/fake_auth', to: 'authentication#fake_auth'
      get '/test', to: 'authentication#test'
    end
  end
end
