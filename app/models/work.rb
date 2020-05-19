class Work < ApplicationRecord
  has_many :votes

  validates :category, inclusion: {
    in: %w(album book movie),
    message: "invalid category"
  }
  validates :title, presence: true

  def votes
    return self.users.count
  end

  def self.by_category(category)
    return Work.order(title: :asc).where(category: category)
  end

  def self.top(category, n)
    return Work.order(title: :asc).where(category: category).limit(n)
  end

  def self.spotlight
    return Work.order(title: :asc).first
  end

  def voted?(user)
    return self.users.include?(user)
  end

  def upvote(user)
    self.users.push(user)
  end

end
