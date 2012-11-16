FoSsoIdp::Application.routes.draw do
  
  resources :users

  get   '/login' => 'login#new'
  get   '/saml/new' => 'saml_idp#new'
  get  '/saml/auth' => 'saml_idp#create'

  post  '/saml/init' => 'saml#init'
  post  '/saml/consume' => 'saml#consume'
  
  root  :to => 'saml_idp#new'

end
