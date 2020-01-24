Rails.application.routes.draw do
  devise_for :users
  root 'pages#landing'

  #header
  get 'about' => 'pages#about'

  #registration/authentication
  devise_scope :user do
    get 'authenticate' => 'devise/sessions#new'
    get 'registration' => 'devise/registrations#new'
    delete 'sign_out' => 'devise/sessions#destroy'
  end

end
