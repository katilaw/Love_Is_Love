require 'rails_helper'
include ActionView::Helpers::DateHelper

feature 'user views story details', %{
  As an authenticated user
  I want to sign in
  view a story's details
} do

  # [√] I should see an index of all stories at the root of the app
  # [√] Should navigate to show page and see the title, date

  scenario "authenticated user sees story details" do
    user = FactoryGirl.create(:user)
    stories = FactoryGirl.create_list(:story, 10)

    user_sign_in(user)

    stories.each do |story|
      expect(page).to have_link(story.title, exact: true)
      expect(page).to have_content(story.short_body)
      expect(page).to have_content(time_ago_in_words(story.updated_at))
    end

    click_link(stories.last.title)
    expect(page).to have_content(stories.last.title)
    expect(page).to have_content(stories.last.body)
  end
end
