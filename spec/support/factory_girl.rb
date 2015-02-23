RSpec.configure do |config|
  # additional factory_girl configuration

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  #   begin
  #     DatabaseCleaner.start
  #     # FactoryGirl.lint
  #   ensure
  #     DatabaseCleaner.clean
  #   end
  end