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
       user_info: {
        first_name:   "John",
        last_name: "Doe",
        email: 'johndoe@example.com'
       }
       creditials:{
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
      client = double('koala facebook api', get_object: facebook_attributes)
      Koala::Facebook::API.stub(:new).and_return(client)
    end
  end
end