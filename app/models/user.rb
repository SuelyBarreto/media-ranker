class User < ApplicationRecord
  has_many :votes

  validates :name, uniqueness: true, presence: true

  def votes
    return self.works.count
  end
end
