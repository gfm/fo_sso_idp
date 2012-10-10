FoSsoIdp::Application.routes.draw do
  
  resources :users

  get   '/login' => 'login#new'
  get   '/saml/auth' => 'saml_idp#new'
  post  '/saml/auth' => 'saml_idp#create'

  get   '/saml/init' => 'saml#init'
  post  '/saml/consume' => 'saml#consume'
  
  root  :to => 'saml#init'

end
