class Wine < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :variety
  has_many :reviews
  has_many :wines, through: :reviews

  def variety_attributes=(attributes)
    variety = Variety.find_or_create_by(attributes)
    self.variety = variety if variety.valid?
  end

  def self.by_variety(v)
    where(variety: v)
  end

  def self.red
    Wine.all.select { |wine| Variety.red.include?(wine.variety) }
  end

  def self.white
    Wine.all.select { |wine| Variety.white.include?(wine.variety) }
  end

  def self.pink
    Wine.all.select { |wine| Variety.pink.include?(wine.variety) }
  end

  def average_rating
    if self.reviews.count > 0
      (self.reviews.sum { |review| review.rating }.to_f / self.reviews.count).round(1).to_s + " stars"
    else
      "No Reviews"
    end
  end
end
