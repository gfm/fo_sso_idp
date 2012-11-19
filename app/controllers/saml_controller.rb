class SamlController < ApplicationController

    def init
      request = Onelogin::Saml::Authrequest.new
      ss = saml_settings(params[:wellpoint_user][:environment], params[:wellpoint_user][:id])
      redirect_to(request.create(ss))
    end

    def consume
      settings = saml_settings
      response = Onelogin::Saml::Response.new(params[:SAMLResponse], {}, settings.private_key)
      response.settings = settings

      valid = response.is_valid?
      response.attributes

      if valid && user = WellpointUser.find_by_id(response.name_id)
        authorize_success(user)
      else
        authorize_failure(user)
      end
    end

    def authorize_success(user)
      @result = "Successful :)"
      render :template => 'saml/result'
    end

    def authorize_failure(user)
      @result = "Failed :("
      render :template => 'saml/result'
    end

    private

    def saml_settings(environment, id = nil)
      settings = Onelogin::Saml::Settings.new

      settings.assertion_consumer_service_url = SSO_SETTINGS[environment]["assertion_consumer_service_url"]
      settings.issuer                         = SSO_SETTINGS[environment]["issuer"]

      settings.idp_sso_target_url = "#{request.protocol}#{request.host_with_port}/saml/auth?issuer=#{settings.issuer}#{id.nil? ? '' : '&id='+id.to_s}"
      
      settings
    end
  end
