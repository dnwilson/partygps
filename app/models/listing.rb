class Listing < ActiveRecord::Base
  belongs_to :category
  belongs_to :event
end
