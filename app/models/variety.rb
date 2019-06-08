class Variety < ApplicationRecord
  validates :color, presence: true
  validates :name, presence: true

  has_many :wines

 #  scope :red, -> { where(color: 'red') }
 #  scope :white, -> { where(color: 'white') }
 #  scope :pink, -> { where(color: 'pink') }

  scope :selected_color, -> (color) { where(color: color) }

  scope :popular, -> { joins(:wines).group(:variety_id).order("count(wines.id) DESC").limit(1)}
end
