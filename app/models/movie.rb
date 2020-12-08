class Movie < ApplicationRecord
  validates :api_id, :title, presence: true

  has_many :parties
end
