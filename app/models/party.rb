class Party < ApplicationRecord
  validates_presence_of :user_id, :movie_id, :date, :time, :duration

  belongs_to :user
  belongs_to :movie

  def formatted_time
    self.time.strftime("%l:%M %p")
  end

  def formatted_date
    self.date.strftime("%B %e, %Y")
  end
end
