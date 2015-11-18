class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates :rating, presence: true
  validates :business_id, presence: true
  validates :user_id, presence: true
end
