require 'rails_helper'

describe "As a visitor" do
  describe "I try to access pages that require a user" do
    it "I try to visit the dashboard" do
      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the discover page" do
      visit discover_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the movies index" do
      visit movies_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the top rated movies page" do
      visit movies_top_rated_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the movies show page" do
      visit movie_show_path("13")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "I try to visit the new viewing party page" do
      visit viewing_party_new_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
