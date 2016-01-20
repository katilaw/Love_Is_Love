require 'rails_helper'
feature 'let an authenticated user comment on a story', %{
    As an authenticated user
    I want to have access to the stories
    So I can comment on them
} do

  # Acceptance:
  # [] I can comment on a story
  # [] A successfully comment should appear story's show page
  # [] Most recent comments should appear first
  # [] An unsuccessful comment should not appear on the stories show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story) }

  scenario 'user successfully creates new comment' do
    user_sign_in(user)
    click_link(story.title)
    click_link('Create Comment')
    fill_in 'Body', with: 'Aww, a what lovely story.'
    click_button('Add Comment')

    expect(page).to have_content(story.title)
    expect(page).to have_content(story.body)
    expect(page).to have_content('Comment Posted!')
    expect(page).to have_content('Aww, a what lovely story.')
  end

  scenario 'user fails to create comment' do
    user_sign_in(user)
    click_link(story.title)

    click_link('Create Comment')
    fill_in 'Body', with: ''
    click_button('Add Comment')
    expect(page).to have_content('Comment can\'t be blank!')
  end

  scenario 'unauthenticated user can\'t comment' do
    visit

    expect(page).to have_content(story.body)
    expect(page).to have_content('Aww, what lovely story.')
  end
end
