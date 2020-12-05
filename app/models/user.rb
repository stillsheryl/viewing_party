class User < ApplicationRecord
  has_secure_password
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  has_many :guests
  has_many :parties, through: :guests

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
end
