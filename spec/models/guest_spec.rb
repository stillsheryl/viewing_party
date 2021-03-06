require 'rails_helper'

describe Guest, type: :model do
  describe "relationships" do
    it { should belong_to :party }
    it { should belong_to :user }
  end
end
