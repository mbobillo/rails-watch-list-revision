class Bookmark < ApplicationRecord
  validates :movie_id, presence: true
  validates :list_id, presence: true
  validates :movie_id, uniqueness: { scope: :list_id, message: "is already in this list" }
  validates :comment, length: { minimum: 6 }
  belongs_to :movie
  belongs_to :list
end
