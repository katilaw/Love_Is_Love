require 'rails_helper'

feature 'user creates a stoy link', %{
  As an authenticated user
  Link to another user's story
  So new users can view my story link on that user's story show page
} do

  # Acceptance Criteria:
  # [] User2 story appears on User1 story show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story,
    title: "Hello World", creator: user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:story2) { FactoryGirl.create(:story, creator: user2) }

  scenario 'user sees recent link request' do
    user_sign_in(user)
    click_link(story2.title)
    click_on("Link Request")

    select "Hello World", from: "Story Collections"
    click_button("Create Story link")

    visit story_path(story)
    expect(page).to have_content(story.title)
    expect(page).to have_content(story.body)

    click_on("Stories Linked To Page")
    expect(page).to have_link(story2.title)
  end
end
