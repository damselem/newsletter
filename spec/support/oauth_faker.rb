module OauthFaker

  def oauth_fake_params
    {
      :provider    => 'google_oauth2',
      :uid         => '123456789',
      :credentials => {
        :token => '987654321'
      },
      :info => {
        :first_name => 'Daniel',
        :last_name  => 'Salmeron Amselem'
      }
    }
  end

end
