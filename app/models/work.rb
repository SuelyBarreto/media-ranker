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
end
