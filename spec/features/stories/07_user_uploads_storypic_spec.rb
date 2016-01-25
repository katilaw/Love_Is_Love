require "rails_helper"

feature "story photo" do
  # Acceptance Criteria:
  # [] If I am logged in, I can optionally add a pciture with my story
  let!(:user) { FactoryGirl.create(:user) }

  scenario "user uploads a story photo" do
    user_sign_in(user)
    click_link "Add New Story"

    fill_in 'Title', with: 'Hello Love. I am ...'
    fill_in 'Body', with: 'I ran away from home last month
      to get married to I guy I met the night before.'
    attach_file 'story[story_photo]',
      "#{Rails.root}/app/assets/images/bench.jpg"
    click_button 'Create Story'
    expect(page).to have_content("Story Created Successfully!")
    expect(page).to have_css("img[src*='bench.jpg']")
  end
end
