class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  
  has_many :reviews
  has_many :wines, through: :reviews
end
