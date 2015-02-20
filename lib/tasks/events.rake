namespace :events do
  desc "Create random events"
  task :random => :environment do 
    p "Creating events"
    Category.all.each do |category|
      i = 0
      7.times do
        if category.name.eql?("Regular")
          FactoryGirl.create(:event, category: category, location: Location.all.sample)
        else 
          FactoryGirl.create(:event, category: category, location: Location.all.sample,
            listed_type: OCCURRENCE.sample, listed_day: DAYNAMES.sample, listed_month: MONTHNAMES.sample)
        end
        i+=1
      end
      p "Created #{i} events in the #{category.name} category"
    end
  end
end