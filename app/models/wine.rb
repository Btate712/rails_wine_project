class Wine < ApplicationRecord
  belongs_to :variety
  has_many :reviews
  has_many :wines, through: :reviews 
end
