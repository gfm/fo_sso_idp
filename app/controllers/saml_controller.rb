class SamlController < ApplicationController
    def init
      request = Onelogin::Saml::Authrequest.new
      redirect_to(request.create(saml_settings))
    end

    def consume
      response          = Onelogin::Saml::Response.new(params[:SAMLResponse])
      response.settings = saml_settings

      if response.is_valid? && user = User.find_by_email(response.name_id)
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

    def saml_settings
      settings = Onelogin::Saml::Settings.new

      # local consume test
      settings.assertion_consumer_service_url = "http://localhost:3000/saml/consume"
      
      # fitorbit.dev consume test
      # settings.assertion_consumer_service_url = "http://fitorbit.dev/saml/consume"

      settings.idp_sso_target_url             = "http://localhost:3000/saml/auth"
      settings.issuer                         = "http://localhost:3000"
      settings.idp_cert_fingerprint           = "9E:65:2E:03:06:8D:80:F2:86:C7:6C:77:A1:D9:14:97:0A:4D:F4:4D"
      settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
      
      # Optional for most SAML IdPs
      # settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

      settings
    end
  end