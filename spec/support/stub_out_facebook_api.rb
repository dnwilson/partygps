# RSpec.configure do |config|
#   config.extend StubOutFacebookApi
# end

module StubOutFacebookApi
  def stub_out_facebook_api!
    include MethodsAvailableToSpecs

    before do
      setup_facebook_user!
    end
  end

  module MethodsAvailableToSpecs
    def facebook_default_attributes
      {id:     "12345678",
       info: {
        first_name:   "John",
        last_name: "Doe",
        email: 'johndoe@example.com'
       },
       creditials: {
        token: 'mock_token',
        secret: 'mock_secret'
       }
      }
    end

    #overridable
    def facebook_attributes
      facebook_default_attributes
    end


    def setup_facebook_user!
      client = double(facebook_attributes.token, get_object: facebook_attributes)
      # Koala::Facebook::API.stub(:new).and_return(client)
      stub_request(:get, "https://graph.facebook.com/me?access_token=mock_token").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
         to_return(:status => 200, :body => "", :headers => {}).and_return(client)
    end
  end
end