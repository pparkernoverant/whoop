class Business < ActiveRecord::Base
  has_many :reviews

  validates :name, presence: true, uniqueness: true
end
