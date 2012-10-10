class SamlIdpController < ApplicationController
  include SamlIdp::Controller

  before_filter :validate_saml_request

  def new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    user = User.find_by_email_and_password(email, password)
    render :action => 'new' if user.nil?
  
    @saml_response = encode_SAMLResponse(user.email)
    render :action => 'response'
  end

end