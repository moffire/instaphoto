Rails.application.routes.draw do

  #REST for Photo model
  resources :photos

  #root_path
  root 'pages#landing'

  #header
  get 'about' => 'pages#about'

  #registration/authentication
  devise_for :users

  devise_scope :user do
    get 'authenticate' => 'devise/sessions#new'
    get 'registration' => 'devise/registrations#new'
    delete 'sign_out' => 'devise/sessions#destroy'
  end

end
