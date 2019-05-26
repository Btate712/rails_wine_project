class Wine < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :variety
  has_many :reviews
  has_many :wines, through: :reviews

  def self.by_variety(v)
    where(variety: v)
  end
end
