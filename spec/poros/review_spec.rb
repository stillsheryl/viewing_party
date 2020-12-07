require 'rails_helper'

describe Review do
  it "exists" do
    attrs = {id: 57, author: 'Test', content: 'content'}
    review = Review.new(attrs)

    expect(review.review_id).to eq(attrs[:id])
    expect(review.author).to eq(attrs[:author])
    expect(review.content).to eq(attrs[:content])
  end
end
