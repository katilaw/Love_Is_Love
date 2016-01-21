require 'rails_helper'
feature 'user deletes comment', %{
  As the creator of the comment
  I want to destroy the comment
  So I can delete the content
} do

  # Acceptance Criteria:
  # [√] I must be able delete comment
  # [√] Comment must be removed from story show page
  # [√] Only story creater & comment creator can delete comment

  let!(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story, creator: user) }
  let(:story2) { FactoryGirl.create(:story, creator: user2) }
  let(:comment) { FactoryGirl.create(:comment, story: story, creator: user) }
  let(:comment2) { FactoryGirl.create(:comment, story: story, creator: user2) }

  scenario 'user deletes comment successfully' do
    user2
    story2
    comment
    comment2

    user_sign_in(user2)

    expect(page).to have_content(story.title)
    expect(page).to have_content(story2.title)

    click_link(story.title)
    click_button('Delete Comment')

    expect(page).to have_content('Comment Deleted!')
    expect(page).to have_content(story.title)
    expect(page).to have_content(comment.body)
    expect(page).to_not have_content(comment2.body)
  end

  scenario 'story creator deletes comment successfully' do
    user2
    story2
    comment
    comment2

    user_sign_in(user)

    click_link(story.title)
    within(".comment-#{comment2.id}") do
      click_button('Delete Comment')
    end

    expect(page).to have_content("You've removed an unwanted comment.")
    expect(page).to have_content(comment.body)
    expect(page).to_not have_content(comment2.body)
  end

  scenario 'other user attempts to delete story' do
    user2
    comment
    user_sign_in(user2)

    click_link(story.title)

    expect(page).to_not have_button('Delete Story')
  end
end
