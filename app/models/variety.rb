class Variety < ApplicationRecord
  validates :color, presence: true
  validates :name, presence: true

  has_many :wines

  def self.red
    where(color: 'red')
  end

  def self.white
    where(color: 'white')
  end

  def self.pink
    where(color: 'pink')
  end
end
