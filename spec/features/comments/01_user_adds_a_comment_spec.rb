require 'rails_helper'
require 'orderly'
feature 'let user comment on a story', %{
    As an authenticated user
    I want to have access to the stories
    So I can comment on them
} do

  # Acceptance:
  # [√] Authenticated user can comment on a story√
  # [√] A successfully comment should appear story's show page
  # [√] Most recent comments should appear first
  # [√] An unsuccessful comment should not appear on the stories show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story) }
  let!(:comment) { FactoryGirl.create(:comment, story: story, creator: user) }

  scenario 'user successfully creates new comment' do
    user_sign_in(user)
    click_link(story.title)
    click_link('Add Comment')
    fill_in 'Body', with: 'Aww, a what lovely story.'
    click_button('Create Comment')

    expect(page).to have_content(story.title)
    expect(page).to have_content(story.body)
    expect(page).to have_content('Comment Posted!')
    expect(page).to have_content('Aww, a what lovely story.')
    expect(page).to have_content(comment.body)
    expect('Aww, a what lovely story.').to appear_before(comment.body)
  end

  scenario 'user fails to create comment' do
    user_sign_in(user)
    click_link(story.title)

    click_link('Add Comment')
    fill_in 'Body', with: ''
    click_button('Create Comment')
    expect(page).to have_content('Comment can\'t be blank!')
  end

  scenario 'unauthenticated user can\'t comment' do
    visit root_path
    click_link(story.title)

    expect(page).to have_content(story.body)
    expect(page).to_not have_content('Aww, what lovely story.')
    expect(page).to_not have_link('Add Comment')
    expect(page).to_not have_button('Create Comment')
  end
end
