require "rails_helper"

feature "profile photo" do
  # Acceptance Criteria:
  # [] If I am logged in, I can optionally add a pciture with my story

  scenario "user uploads a story photo" do
    user_sign_in(user)
    click_link "Add New Story"

    fill_in 'Title', with: test_title
    fill_in 'Body', with: test_body
    click_button 'Create Story'
    attach_file 'user[profile_photo]',
      "#{Rails.root}/spec/support/images/photo.png"
    click_button "Sign Up"

    expect(page).to have_content("Welcome to the club!")
    expect(page).to have_css("img[src*='bench.jpg']")
  end
end
