class Variety < ApplicationRecord
  validates :color, presence: true
  validates :name, presence: true
  
  has_many :wines
end
