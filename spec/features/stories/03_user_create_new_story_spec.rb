require 'rails_helper'

feature 'user adds story', %{
  As a User
  I want to add a story
  So I can share my story
} do

  # Acceptance Criteria:
  # [√] If I am logged in, I can click a button on the index to
  #     add a new story
  #     and be brought to a form on the 'new' page
  # [√] If I am logged in, and I fill out the form incorrectly,
  #     I am given an error
  # [√] If I am not logged in, I should be told to log in before adding
  #     a new story
  # [√] On successful submission, user is brought to the show page
  # [√] If I do not fill out the required fields, I should see errors
  # [√] On error, the story should not appear on the index

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'logged in user navigates to `new` page' do
    user_sign_in(user)
    visit stories_path
    click_link 'Add New Story'

    expect(current_path).to eq(new_story_path)
    expect(page).to have_css('form')
  end

  scenario 'logged in user adds new story' do
    test_title = 'Hence, the chicken crossed the road'
    test_body = 'We grew up on different sides of the tracks'

    user_sign_in(user)
    click_link 'Add New Story'
    fill_in 'Title', with: test_title
    fill_in 'Body', with: test_body
    click_button 'Create Story'

    expect(page).to have_content('Story Created Successfully!')
    expect(page).to have_content(test_title)
    expect(page).to have_content(test_body)

    visit stories_path
    expect(page).to have_content(test_title)
  end

  scenario 'logged in user incorrectly fills out form' do
    test_body = 'We grew up on different sides of the tracks'

    user_sign_in(user)
    click_link 'Add New Story'

    fill_in 'Body', with: test_body
    click_button 'Create Story'
    expect(page).to have_content('Oops! You forgot 1 or more required fields.')
    expect(find_field('Body').value).to eq(
      test_body
    )

    visit stories_path
    expect(page).to_not have_content(test_body)
  end

  scenario 'unauthenticated user cannot a create story' do
    visit stories_path
    expect(page).to_not have_link(
      'Create Story'
    )
  end
end
