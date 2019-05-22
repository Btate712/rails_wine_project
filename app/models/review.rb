class Review < ApplicationRecord
  validates :user, presence: true, uniqueness: false
  validates :wine, presence: true
  validates :rating, presence: true, numericality:
    { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :heaviness, :fruitiness, :acidity, numericality:
    { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }

  belongs_to :user
  belongs_to :wine
end
