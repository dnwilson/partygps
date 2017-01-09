class Tag < ApplicationRecord
  has_many :taggings
  has_many :events, thru: :taggings
end
