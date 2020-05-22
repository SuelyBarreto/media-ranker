class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  
  validates :name, uniqueness: true, presence: true
end
