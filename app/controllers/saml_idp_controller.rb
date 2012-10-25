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
    
    @saml_response = custom_encode_SAMLResponse(user.sbscrbr_id, {}, default_attributes(user))

    render :action => 'response'
  end

  def custom_encode_SAMLResponse(nameID, opts = {}, attributes = [])
        now = Time.now.utc
        response_id, reference_id = UUID.generate, UUID.generate
        audience_uri = opts[:audience_uri] || saml_acs_url[/^(.*?\/\/.*?\/)/, 1]
        issuer_uri = opts[:issuer_uri] || (defined?(request) && request.url) || "http://example.com"
        
        attribute_statement = ""
        if attributes.count > 0
          attributes.each do |a|
            attribute_statement += 
            '<Attribute NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" Name="'+a[:name]+'">' +
              '<AttributeValue>'+"#{a[:value]}"+'</AttributeValue>' +
            '</Attribute>'
          end
          attribute_statement
        end

        assertion = %[<Assertion xmlns="urn:oasis:names:tc:SAML:2.0:assertion" ID="_#{reference_id}" IssueInstant="#{now.iso8601}" Version="2.0"><Issuer>#{issuer_uri}</Issuer><Subject><NameID Format="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress">#{nameID}</NameID><SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer"><SubjectConfirmationData InResponseTo="#{@saml_request_id}" NotOnOrAfter="#{(now+3*60).iso8601}" Recipient="#{@saml_acs_url}"></SubjectConfirmationData></SubjectConfirmation></Subject><Conditions NotBefore="#{(now-5).iso8601}" NotOnOrAfter="#{(now+60*60).iso8601}"><AudienceRestriction><Audience>#{audience_uri}</Audience></AudienceRestriction></Conditions><AttributeStatement><Attribute NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" Name="EmailAddress"><AttributeValue>#{nameID}</AttributeValue></Attribute>#{attribute_statement}</AttributeStatement><AuthnStatement AuthnInstant="#{now.iso8601}" SessionIndex="_#{reference_id}"><AuthnContext><AuthnContextClassRef>urn:federation:authentication:windows</AuthnContextClassRef></AuthnContext></AuthnStatement></Assertion>]

        digest_value = Base64.encode64(algorithm.digest(assertion)).gsub(/\n/, '')

        signed_info = %[<ds:SignedInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#"><ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"></ds:CanonicalizationMethod><ds:SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-#{algorithm_name}"></ds:SignatureMethod><ds:Reference URI="#_#{reference_id}"><ds:Transforms><ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"></ds:Transform><ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"></ds:Transform></ds:Transforms><ds:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig##{algorithm_name}"></ds:DigestMethod><ds:DigestValue>#{digest_value}</ds:DigestValue></ds:Reference></ds:SignedInfo>]

        signature_value = sign(signed_info).gsub(/\n/, '')

        signature = %[<ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">#{signed_info}<ds:SignatureValue>#{signature_value}</ds:SignatureValue><KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#"><ds:X509Data><ds:X509Certificate>#{self.x509_certificate}</ds:X509Certificate></ds:X509Data></KeyInfo></ds:Signature>]

        assertion_and_signature = assertion.sub(/Issuer\>\<Subject/, "Issuer>#{signature}<Subject")

        xml = %[<samlp:Response ID="_#{response_id}" Version="2.0" IssueInstant="#{now.iso8601}" Destination="#{@saml_acs_url}" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified" InResponseTo="#{@saml_request_id}" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"><Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">#{issuer_uri}</Issuer><samlp:Status><samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success" /></samlp:Status>#{assertion_and_signature}</samlp:Response>]

        Base64.encode64(xml)
      end

  private 

    def default_attributes(user)
      [
        { name: "SbscrbrId",  value: user.sbscrbr_id.to_s },
        { name: "FirstName",  value: user.frst_nm.to_s },
        { name: "LastName",   value: user.lst_nm.to_s }
      ]
    end

end

# <saml:AttributeStatement>
#   <saml:Attribute Name="givenName">
#       <saml:AttributeValue xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion">
#           RkVJREUgVGVzdCBVc2VyIChnaXZlbk5hbWUpIMO4w6bDpcOYw4bDhQ==
#       </saml:AttributeValue>
#   </saml:Attribute>
# </saml:AttributeStatement>

# Attribute Name      Description
# --------------------------------------------
# SBSCRBR_ID          Subscriber ID
# MBR_SQNC_NBR        Member Sequence Number
# MBRSHP_SOR_CD       Source System Code
# Group Number  
# Subgroup Number 
# FirstName 
# LastName  
# MiddleInitial 
# DOB 
# Gender  
# Email 
# WlpUserId Added by siteminder for audit