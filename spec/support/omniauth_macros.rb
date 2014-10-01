module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545678',
      'user_info' => {
        'first_name' => 'John',
        'last_name' => 'Doe',
        'email' => 'johndoe@example.com'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }

    OmniAuth.config.mock_auth[:google] = {
      'provider' => 'google',
      'uid' => '87654321',
      'user_info' => {
        'first_name' => 'Jane',
        'last_name' => 'Doe',
        'email' => 'janedoe@example.com'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end
end