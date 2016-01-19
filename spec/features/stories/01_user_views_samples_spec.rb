require 'rails_helper'

feature 'Let an authenticated user add a story', %{
  As an authenticated user
  I want to add my story
  So it can be displayed on the app
} do

# ACCEPTANCE CRITERIA
# [ ] I can see a button to add a new story
# [ ] If successful, success notice should display
# [ ] Upon success, redirected to the story's show page
# [ ] An inadequte form should generate errors
# [ ] Unsuccessful submision, should not be saved

  let!(:user) { FactoryGirl.create(:user) }
  let!(:story2) { FactoryGirl.create(:story) }

  scenario 'user creates a new story successfully' do
    visit root_path
    user_sign_in(user)

    click_button('Add Story')
    fill_in 'Title', with: 'A New Beginning'
    fill_in 'Body', with: 'Once Upon A Time, in a land not far away'
    click_button('Create Story')

    expect(page).to have_content('Your story was successfully created')
    expect(page).to have_content('A New Beginning')
    expect(page).to have_content('Once Upon A Time, in a land not far away')
    expect(page).to_not have_content(story2.title)
    expect(page).to_not have_content(story2.body)
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
  end

  scenario 'user fails to create a story' do
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
