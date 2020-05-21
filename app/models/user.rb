class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  
  validates :name, uniqueness: true, presence: true
 
  def voted?(work)
    return Vote.voted?(work, self)
  end

  def upvote(work)
    Vote.upvote(work, self)
  end

end
