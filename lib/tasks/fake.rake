# Now the rake task
# place this in lib/tasks/fake.rake
 
require 'fakeout'
 
desc "Fakeout data"
task :fake => :environment do
  faker = Fakeout::Builder.new
 
  # fake users
  faker.users(9)
  faker.users(1, { email: 'admin@test.com' }, true)
 
  # fake events
  faker.events(12)
  faker.events(15, {}, true)
 
  # report
  puts "Faked!\n#{faker.report}"
end