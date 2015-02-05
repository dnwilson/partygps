# config/initializers/geocoder.rb
if Rails.env.test?
  Geocoder.configure(:lookup => :test)

  Geocoder::Lookup::Test.add_stub(
    "New York, NY", [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ])
  Geocoder::Lookup::Test.add_stub(
    "1 Testing Way, Testville, Kingston, Jamaica", [
      {
        'latitude'     =>  18,
        'longitude'    =>  -76.8,
        'region'      => '',
        'city'        => 'Kingston',
        'country'      => 'Jamaica',
        'country_code' => 'JM'
      }
    ]
  )
  Geocoder::Lookup::Test.add_stub(
    "Kingston, Jamaica", [
      {
        'latitude'     =>  18,
        'longitude'    =>  -76.8,
        'region'      => '',
        'city'        => 'Kingston',
        'country'      => 'Jamaica',
        'country_code' => 'JM'
      }
    ]
  )
  Geocoder::Lookup::Test.add_stub(
    "Portmore, Jamaica", [
      {
        'latitude'     =>  17.9667,
        'longitude'    =>  -76.8667,
        'region'      => 'St. Catherine',
        'city'        => 'Portmore',
        'country'      => 'Jamaica',
        'country_code' => 'JM'
      }
    ]
  )
  Geocoder::Lookup::Test.add_stub(
    "Negril, Jamaica", [
      {
        'latitude'     =>  14,
        'longitude'    =>  -79,
        'region'      => 'Westmoreland',
        'city'        => 'Negril',
        'country'      => 'Jamaica',
        'country_code' => 'JM'
      }
    ]
  )
else
  Geocoder.configure(
    # geocoding service (see below for supported options):
    # :lookup => :yandex,
    # lookup: :bing,
    # key: "AsfNsF1veuhARaTdpIlFSk7czMXyscbi0YCWpZeyF4ns4KCMxyQR4GFmJJ7La6vC",
    # lookup: :google
    # api_key: 

    # IP address geocoding service (see below for supported options):
    ip_lookup: :telize,

    # to use an API key:
    # :api_key => "...",

    # geocoding service request timeout, in seconds (default 3):
    timeout: 5,

    # set default units to kilometers:
    units: :km,

    # caching (see below for details):
    cache: Rails.cache
    # cache_prefix: "..."

  )
end
