Rails.application.routes.draw do

  #REST for Photo model
  resources :photos

  #root_path
  root 'pages#landing'

  #user_profile
  get '/profiles/:id' => 'profiles#show', as: 'profile'
  get '/profiles/:id/subscribe' => 'profiles#subscribe', as: 'subscribe_profile'
  get '/profiles/:id/unsubscribe' => 'profiles#unsubscribe', as: 'unsubscribe_profile'


  #registration/authentication
  devise_for :users

  devise_scope :user do
    get 'authenticate' => 'devise/sessions#new'
    get 'registration' => 'devise/registrations#new'
    post 'registration' => 'devise/registrations#create'
    put 'registration' => 'devise/registrations#update'
    delete 'sign_out' => 'devise/sessions#destroy'
    get 'sign_in' => 'devise/sessions#new'
  end

end
