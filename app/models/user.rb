class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true

  has_many :reviews
  has_many :wines, through: :reviews

  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(username: auth.info.email).first_or_initialize do |user|
      user.username = auth.info.email.split("@").first
      user.password ||= SecureRandom.hex
    end
  end
end
