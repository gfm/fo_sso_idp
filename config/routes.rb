FoSsoIdp::Application.routes.draw do
  
  get   '/login' => 'login#new'
  get   '/saml/auth' => 'saml_idp#new'
  post  '/saml/auth' => 'saml_idp#create'

  root  :to => 'login#new'

end
