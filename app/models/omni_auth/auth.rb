module OmniAuth
  class Auth
    def initialize(attributes = {})
      @attributes = HashWithIndifferentAccess.new(attributes)
    end

    def is_token_valid?
      token_validation[:audience] == ENV['GOOGLE_OAUTH_KEY']
    end

    def is_klarna_account?
      token_validation[:email].match(/@klarna.com$/)
    end

    private

    def token_validation
      @token_validation ||= begin
        options  = {
          :params => { :access_token => @attributes[:credentials][:token] }
        }

        response = Typhoeus.get(ENV['GOOGLE_OAUTH_TOKEN_URL'], options)

        HashWithIndifferentAccess.new(JSON.parse(response.body))
      end
    end

  end
end
