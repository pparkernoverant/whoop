class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true, on: :create
end
