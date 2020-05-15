class User < ApplicationRecord
  has_and_belongs_to_many :works

  validates :name, uniqueness: true, presence: true

  def votes
    return self.works.count
  end
end
