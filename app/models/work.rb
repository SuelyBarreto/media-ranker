class Work < ApplicationRecord
  has_and_belongs_to_many :users

  validates :category, inclusion: {
    in: %w(album book movie),
    message: "%{value} is not a valid category"
  }
  validates :title, presence: true
end
