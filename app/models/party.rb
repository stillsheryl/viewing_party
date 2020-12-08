class Party < ApplicationRecord
  validates :user_id, :movie_id, :date, :time, :duration, presence: true

  belongs_to :user
  belongs_to :movie

  def formatted_time
    time.strftime('%l:%M %p')
  end

  def formatted_date
    date.strftime('%B %e, %Y')
  end
end
