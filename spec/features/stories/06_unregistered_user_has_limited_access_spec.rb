require 'rails_helper'

feature 'Allow unauthenticated user limited access', %{
  As an unregistered user
  I want to browse some stories
  To get a feel for the site before signing up
} do

  # ACCEPTANCE CRITERIA
  # [√] If successful, success notice should display
  # [√] Upon success, redirected to the story's show page
  # [√] An inadequte form should generate errors
  # [√] Unsuccessful submision, should not be saved

  let :story_list { FactoryGirl.create_list(:story, 8) }

  scenario 'unauthenticated user views only 6 stories' do
    story_list
    visit root_path
    story_list[2..7].each do |story|
      expect(page).to have_content(story.title)
    end

    story_list[0..1].each do |story|
      expect(page).to_not have_content(story.title)
    end
  end

  scenario 'unauthenticated user fails to create a story' do
    visit root_path

    click_link('Add New Story')

    expect(page).to have_content('You must be signed in to add a story!')
  end
end
