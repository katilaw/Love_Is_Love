require 'rails_helper'
require 'orderly'
include ActionView::Helpers::DateHelper

feature 'user view story list', %{
  As an authenticated user
  I want to sign in
  view a list on avalible stories
} do

# [√] I should see an index of all stories at the root of the app
# [√] I should see the title, date
# [] I should see a list sorted by date by default

  feature "authenticate user sees list of stories" do
    xscenario "user sees the latest 10 storiess" do
      user = FactoryGirl.create(:user)
      stories = FactoryGirl.create_list(:story, 10)

      user_sign_in(user)

      stories.each do |story|
        expect(page).to have_link(story.title, exact: true)
        expect(page).to have_content(story.short_body)
        expect(page).to have_content(time_ago_in_words(story.updated_at))
      end
      save_and_open_page
      expect(stories.second.title).to appear_before(stories.first.title)
      expect(page).to have_link('Add New Story')
    end
  end
end
