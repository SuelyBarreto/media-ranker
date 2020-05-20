class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes
  
  validates :name, uniqueness: true, presence: true

  def votes
    return Vote.user_votes(self)
  end
  
  def voted?(work)
    return Vote.voted?(work, self)
  end

  def upvote(work)
    Vote.upvote(work, self)
  end

end
