require 'rails_helper'

describe "As a visitor" do
  describe "I try to access pages that require a user" do
    it "I try to visit the dashboard" do
      visit '/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the discover page" do
      visit '/discover'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the movies index" do
      visit '/movies'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    
    it "I try to visit the top rated movies page" do
      visit '/movies/top_rated'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    
    it "I try to visit the movies show page" do
      visit '/movies/13'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the new viewing party page" do
      visit '/viewing-party/new'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end