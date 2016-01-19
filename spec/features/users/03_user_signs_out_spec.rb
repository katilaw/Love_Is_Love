require 'rails_helper'

feature 'user signs in', %{
  As a user
  I want to sign out
  So that I can securely leave the site
} do

  # Acceptance Criteria:
  # [√] if I am logged in, I can log out
  # [√] if I am not logged in, there is no option to log out

  scenario 'a signed-in user logs out' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'
    click_link 'Sign Out'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'a logged out user cannot log out' do
    visit root_path

    expect(page).to_not have_content('Sign Out')
  end
end
