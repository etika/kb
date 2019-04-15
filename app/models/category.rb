class Category < ApplicationRecord
  has_many :keywords
  has_many :events
end
