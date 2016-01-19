require 'rails_helper'

feature 'Allow limited access to an authenticated user', %{
  As an authenticated user
  I want to browse some stories
  To get a feel for the site before signing up
} do

# ACCEPTANCE CRITERIA
# [ ] I can see a button to add a new story
# [ ] If successful, success notice should display
# [ ] Upon success, redirected to the story's show page
# [ ] An inadequte form should generate errors
# [ ] Unsuccessful submision, should not be saved

  let!(:user) { FactoryGirl.create(:user) }
  let!(:story_list) { FactoryGirl.create_list(:story, 12) }

  xscenario 'unauthenticated user views only 6 stories' do
    visit root_path
    binding.pry
    expect(Story.all).to (6).items
  end

  xscenario 'user fails to create a story' do
    visit root_path
    user_sign_in(user)

    click_button('Add Story')
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button('Create Story')

    expect(page).to have_content('can\'t be blank')
    expect(page).to have_content('Please complete the required fields')
  end
end
