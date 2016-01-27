require 'rails_helper'

feature 'user send a story link request', %{
  As an authenticated user
  Request permission form another user to link stories
  So new users can view my story link on that user's story show page
} do

  # Acceptance Criteria:
  # [] User1 receives story link notification
  # [] User1 accepts the notification
  # [] User2 story appears on User1 story show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, title:  "Hello World", creator: user) }
  let!(:story2) { FactoryGirl.create(:story, creator: user2) }

  scenario 'user accepts link request' do
    user_sign_in(user)
    click_link(story2.title)
    click_on("Link Request")

    select "Hello World", from: "Story Collections"
    click_button("Create Story link")
    click_on("Sign Out")

    user_sign_in(user2)
    click_link(story2.title)
    click_on("Story Link Requests")
    click_link(story.title)

    expect(page).to have_content(story.body)
    expect(page).to have_content("Requesting to link to: #{story2.title}")
    expect(page).to have_button('Accept Link')
    expect(page).to have_button('Decline Link')

    click_on("Accept Link")
  end

  scenario 'user declines link request' do
    user_sign_in(user)
    click_link(story2.title)
    click_on("Link Request")

    select "Hello World", from: "Story Collections"
    click_button("Create Story link")
    click_on("Sign Out")

    user_sign_in(user2)
    click_on("Story Link Requests")
    click_link(story.title)

    expect(page).to have_content(story.body)
    expect(page).to have_content("Requesting to link to: #{story2.title}")
    expect(page).to have_button('Accept Link')
    expect(page).to have_button('Decline Link')

    click_on("Decline Link")
  end
end
