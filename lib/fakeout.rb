 
require 'faker'
 
module Fakeout
  class Builder
 
    FAKEABLE = %w(User Category Location Event)
 
    attr_accessor :report
 
    def initialize
      self.report = Reporter.new
      clean!
    end
 
    # create users (can be admins)
    def users(count = 1, options = {}, is_admin = false)
      1.upto(count) do 
        user = User.new({ email:                  random_unique_email, 
                          password:               'test1234', 
                          password_confirmation:  'test1234' }.merge(options))
        user.save
        if is_admin
          user.update_attribute(:role, 'admin')
          self.report.increment(:admins, 1)
        end
      end
 
      self.report.increment(:users, count)
    end
 
    # create event (can be free)
    def events(count = 1, options = {}, recurring = false)
      1.upto(count) do
        attributes   = { name:          Faker::Company.catch_phrase,
                         location:      Location.all.sample,
                         category_id:   Category.where(name: REG).first.id, 
                         adm:           20+Random.rand(11),
                         start_dt:      Faker::Time.between(Time.now, 60.days.from_now, :night), 
                         description:   Faker::Lorem.paragraph(2) }.merge(options),
                         photo:         Faker::Avatar.image 
        event      = Event.new(attributes)
        event.save
        if recurring
          event.update_attributes(listed_type:    OCCURRENCE.sample,
                                  listed_day:     DAYNAMES.sample,
                                  listed_month:   MONTHNAMES.sample,
                                  category:       Category.where.not(name: REG).sample)
        end
        
      end
      self.report.increment(:events, count)
    end

    # cleans all faked data away
    def clean!
      FAKEABLE.map(&:constantize).map(&:destroy_all)
    end
 
 
    private
 
    def pick_random(model)
      ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")
      model.find(ids[rand(ids.length)]['id'].to_i) if ids
    end
 
    def random_unique_email
      Faker::Internet.email.gsub('@', "+#{User.count}@")
    end

  end
 
 
  class Reporter < Hash
    def initialize
      super(0)
    end
 
    def increment(fakeable, number = 1)
      self[fakeable.to_sym] ||= 0
      self[fakeable.to_sym] += number
    end
 
    def to_s
      report = ""
      each do |fakeable, count|
        report << "#{fakeable.to_s.classify.pluralize} (#{count})\n" if count > 0
      end
      report
    end
  end
end
 
 
