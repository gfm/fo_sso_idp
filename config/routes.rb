FoSsoIdp::Application.routes.draw do
  
  resources :users

  get   '/login' => 'login#new'
  get   '/saml/auth' => 'saml_idp#new'
  post  '/saml/auth' => 'saml_idp#create'

  get   '/saml/init' => 'saml#init'
  
  root  :to => 'saml#init'

end
