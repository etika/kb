class Role < ApplicationRecord
  has_many :users
  validates :name, :uniqueness => {:case_sensitive => false}

end
