require 'rails_helper'
require 'spec_helper'
require 'orderly'
feature 'let user edit comment', %{
    As an authenticated user
    I want to edit my comment
    So I can update the content
} do

  # Acceptance:
  # [√] I can edit the comment on a story
  # [√] Successfully update appears on the story show page
  # [√] Comments should be ordered by creation date
  # [] An unsuccessful comment should not appear on the stories show page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:story) { FactoryGirl.create(:story) }
  let!(:comment) { FactoryGirl.create(:comment, story: story, creator: user) }

  scenario 'user successfully edits comment' do
    user_sign_in(user)
    click_link(story.title)

    click_link('Edit Comment')
    fill_in 'Body', with: 'Wow. Have you considered writing a book?'
    click_button('Update Comment')

    expect(page).to have_content('Comment Updated!')
    expect(page).to have_content(story.title)
    expect(page).to have_content(story.body)
    expect(page).to have_content('Wow.
      Have you considered writing a book?')
  end

  scenario 'user fails to edits comment' do
    user_sign_in(user)
    click_link(story.title)

    click_link('Edit Comment')
    fill_in 'Body', with: ''
    click_button('Update Comment')
    expect(page).to have_content("Comment can't be blank!")
  end

  scenario 'unauthenticated user can\'t comment' do
    visit root_path
    click_link(story.title)

    expect(page).to have_content(story.body)
    expect(page).to_not have_content('Wow. Have you considered writing a book?')
    expect(page).to_not have_link('Edit Comment')
  end

  scenario 'user attempts to edit another user\'s comment' do
    user_sign_in(user2)
    click_link(story.title)

    expect(page).to_not have_link('Edit Story')
    expect(page).to_not have_button('Delete Story')
    expect(page).to_not have_link('Edit Comment')
    expect(page).to_not have_button('Create Comment')
  end
end
