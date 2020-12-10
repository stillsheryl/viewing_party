require 'rails_helper'

describe 'As a user' do
  before :each do
    User.create(email: 'test@gmail.com', password: 'test', first_name: 'Alex', last_name: 'Rivero')

    visit root_path
    fill_in :email,	with: "test@gmail.com"
    fill_in :password,	with: "test"
    click_button 'Sign In'
  end

  it 'when I visit /discover I expect to see 2 buttons and a text field' do
    visit discover_path
    user = User.last
    expect(page).to have_content("Welcome #{user.first_name} #{user.last_name}")

    expect(page).to have_button('Find Top Rated Movies')
    expect(page).to have_button('Find Movies')
    expect(page).to have_button('Upcoming Movies')
  end

  it "if I try to click on the search button without entering anything, I stay on the discover page" do
    visit discover_path
    user = User.last

    click_button('Find Movies')

    expect(current_path).to eq(discover_path)
    expect(page).to have_content('Search field cannot be blank')
    expect(page).to have_content("Welcome #{user.first_name} #{user.last_name}")
    expect(page).to have_button('Find Top Rated Movies')
    expect(page).to have_button('Find Movies')
  end
end
