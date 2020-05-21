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
    return Vote.where(work_id: self.id, user_id: user.id).size > 0
end

  def upvote(user)
    if voted?(user)
      return false
    end
    Vote.create(work_id: self.id, user_id: user.id, voted_on: Date.today)
    return true
  end

end
