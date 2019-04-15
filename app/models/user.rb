class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,:confirmable
  belongs_to :role
  has_many :polls
  has_many :admins, through: :polls

  def is?(role)
    return  Role.find_by_name(role.to_s).id== self.role_id
  end

end
