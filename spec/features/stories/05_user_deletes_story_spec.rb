require 'rails_helper'
feature 'user deletes story', %{
  As a User and the creator of the story
  I want to destroy the story
  So I can delete the content of the story
} do

  # Acceptance Criteria:
  # [√] I must be able delete a story from the story show page
  # [√] If I am not the creator, I cannot delete the story
  # [√] Delete comments associated with Story

  let!(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:story) { FactoryGirl.create(:story, creator: user) }
  let(:story2) { FactoryGirl.create(:story, creator: user2) }
  let(:comment) { FactoryGirl.create(:comment, story: story) }

  scenario 'navigate to story show page and delete story' do
    story
    story2

    user_sign_in(user)
    expect(page).to have_content(story.title)
    expect(page).to have_content(story2.title)

    click_link(story.title)
    expect(current_path).to eq(story_path(story))

    click_button('Delete Story')
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Your story was safely erased")

    expect(page).to have_content(story2.title)
  end

  scenario 'user attempts to delete another user\'s story' do
    story2

    user_sign_in(user)
    expect(page).to have_content(story2.title)

    click_link(story2.title)

    expect(page).to_not have_button('Delete Story')
  end

  scenario 'Deleting story destroyes comment' do
    story
    story2
    comment

    user_sign_in(user)
    click_link(story.title)

    click_button('Delete Story')

    expect(Comment.all.empty?).to be(true)
  end
end
