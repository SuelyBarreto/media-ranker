class Work < ApplicationRecord
  has_many :votes

  validates :category, inclusion: {
    in: %w(album book movie),
    message: "invalid category"
  }
  validates :title, presence: true

  def self.by_category(category)
    return Work.order(title: :asc).where(category: category)
  end

  def self.top(category, n)
    return Work.order(title: :asc).where(category: category).limit(n)
  end

  def self.spotlight
    return Work.order(title: :asc).first
  end

  def votes
    return Vote.work_votes(self)
  end
  
  def users
    return Vote.users(self)
  end

  def voted?(user)
    return Vote.voted?(self, user)
  end

  def upvote(user)
    Vote.upvote(self, user)
  end

end
