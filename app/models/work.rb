class Work < ApplicationRecord
  has_and_belongs_to_many :users

  validates :category, inclusion: {
    in: %w(album book movie),
    message: "invalid category"
  }
  validates :title, presence: true

  def votes
    return self.users.count
  end

  def self.by_category(category)
    return Work.all.select{ |work| work.category == category }
  end

  def self.top(category, n)
    return Work.by_category(category).sample(n)
  end

  def self.spotlight
    return Work.all.sample
  end
end
