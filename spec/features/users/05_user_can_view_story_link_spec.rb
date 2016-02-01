require 'rails_helper'

feature 'user creates a stoy link', %{
  As an authenticated user
  Link to another user's story
  So new users can view my story link on that user's story show page
} do

  # Acceptance Criteria:
  # [√] User2 story appears on User1 story show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:sto) { FactoryGirl.create(:story, title: "Hi Wor", creator: user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:story2) { FactoryGirl.create(:story, creator: user2) }

  scenario 'user sees recent link request' do
    user_sign_in(user)
    click_link(story2.title)
    click_on("Link Request")

    select "Hi Wor", from: "Story Collections"
    click_button("Create Story Link")

    visit story_path(sto)
    expect(page).to have_content(sto.title)
    expect(page).to have_content(sto.body)

    click_on("Stories Linked To Page")
    expect(page).to have_link(story2.title)
  end
end
