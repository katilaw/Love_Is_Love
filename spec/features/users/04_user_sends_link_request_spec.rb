require 'rails_helper'

feature 'user send a story link request', %{
  As an authenticated user
  Request permission form another user to link stories
  So new users can view my story link on that user's story show page
} do

  # Acceptance Criteria:
  # [√] User sends a Link Request
  # [√] Success notification displays

  let!(:user) { FactoryGirl.create(:user) }
  let!(:sto) { FactoryGirl.create(:story, title: "Hi Wor", creator: user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:story2) { FactoryGirl.create(:story, creator: user2) }

  scenario 'send another user a link request' do
    user_sign_in(user)
    click_link(story2.title)
    click_on("Link Request")

    select "Hi Wor", from: "Story Collections"
    click_button("Create Story Link")

    expect(page).to have_content('Request processesed. Pending approval.')
  end
end
