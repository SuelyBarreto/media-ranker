class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, inclusion: {
    in: %w(album book movie),
    message: "invalid category"
  }
  validates :title, presence: true

  def self.by_category(category)
    return Work.where(category: category).order(title: :asc)
  end

  def self.top(category, n)
    return Work.where(category: category).order(votes_count: :desc, title: :asc).limit(n)
  end

  def self.spotlight
    return Work.order(votes_count: :desc, title: :asc).first
  end
  
  def voted?(user)
    return Vote.voted?(self, user)
  end

  def upvote(user)
    Vote.upvote(self, user)
  end

end
