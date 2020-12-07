class Review
  attr_reader :review_id, :author, :content
  def initialize(review_data)
    @review_id = review_data[:id]
    @author = review_data[:author]
    @content = review_data[:content]
  end
end
