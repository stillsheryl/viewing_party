class User < ApplicationRecord
  has_secure_password
  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  has_many :guests, dependent: :destroy
  has_many :parties, through: :guests

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
end
