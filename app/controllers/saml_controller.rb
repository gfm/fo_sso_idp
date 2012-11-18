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
      
      # # local consume test
      # # settings.assertion_consumer_service_url  = "http://localhost:3000/saml/consume"
      # # settings.issuer                         = "http://localhost:3000"

      # # fitorbit.dev consume test
      # # settings.assertion_consumer_service_url = "http://fitorbit.dev/saml/consume"
      # # settings.issuer                         = "http://fitorbit.dev"

      # # qa.myfitorbit.com consume test
      # settings.assertion_consumer_service_url = "https://qa1.myfitorbit.com/saml/consume"
      # settings.issuer                         = "saml.uat.anthem.com:FitOrbit"
      
      # # #Sample Saml Response
      # # settings.name_identifier_format         = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
      # # settings.idp_cert_fingerprint           = "9E:65:2E:03:06:8D:80:F2:86:C7:6C:77:A1:D9:14:97:0A:4D:F4:4D"
      
      # # #WP Saml Response
      # settings.name_identifier_format         = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
      # settings.idp_cert_fingerprint           = "05:AF:2D:72:4F:0D:5E:E9:2D:49:E8:4F:DC:19:5D:6C:43:67:25:47"
      # settings.private_key                    = "/Users/nate/Downloads/qa.myfitorbit.key"

      settings
    end
  end
