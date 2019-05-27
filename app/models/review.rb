class Review < ApplicationRecord
  validates :user_id, presence: true
  validates :wine, presence: true
  validates :rating, presence: true, numericality:
    { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :heaviness, :fruitiness, :acidity, numericality:
    { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }

  def wine_attributes=(attributes)
    variety = Variety.find_or_create_by(attributes[:variety_attributes])
    attributes[:variety_id] = variety.id if variety.save
    w_attributes = { name: attributes[:name], variety_id: attributes[:variety_id] }
    wine = Wine.find_or_create_by(w_attributes)
    self.wine = wine if wine.valid?
  end

  belongs_to :user
  belongs_to :wine
end
