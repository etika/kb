class Poll < ApplicationRecord
  belongs_to :user
  belongs_to :admin, class_name: 'User'
end
