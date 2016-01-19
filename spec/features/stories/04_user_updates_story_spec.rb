require 'rails_helper'
feature 'user Creates story', %{
  As a User and the creator of the story
  I want to edit the story
  So I can edit the content of the story
} do

  # Acceptance Criteria:
  # [√] I must provide all of the required information
  # [√] If the information is incorrect, I must be provided errors
  # [√] If I am not logged in, I cannot modify the content of the story
  # [] If I am not the creator, I cannot modify the content of the story

  let!(:user) { FactoryGirl.create(:user) }
  let (:tale) { FactoryGirl.create(:story, creator: user) }
  let (:user2) { FactoryGirl.create(:user) }

  scenario 'navigate to story show page and edit story' do
    tale
    user_sign_in(user)
    click_link(tale.title)
    expect(current_path).to eq(story_path(tale))
    click_link('Edit Story')

    expect(find_field('story[title]').value).to eq(tale.title)
    expect(find_field('story[body]').value).to eq(tale.body)

    title = 'Hopefully this work'
    body = 'Testing out this cool new edition to the story'
    fill_in('story[title]', with: title)
    fill_in('story[body]', with: body)
    click_button('Create Story')

    expect(current_path).to eq(story_path(tale))
    expect(page).to have_content(title)
    expect(page).to have_content(body)
    expect(page).to have_content('Story Edited Successfully.')
  end

  scenario 'user attempts to post an invalid title' do
    tale
    user_sign_in(user)
    click_link(tale.title)
    click_link('Edit Story')

    expect(find_field('story[title]').value).to eq(tale.title)
    expect(find_field('story[body]').value).to eq(tale.body)

    body = 'How fast can I type this without making a mistake'
    fill_in('story[title]', with: '')
    fill_in('story[body]', with: body)
    click_button('Create Story')

    expect(page).to have_content("Oops! Please fill
    in all required fields and try again.")
    expect(find_field('story[title]').value).to eq('')
    expect(find_field('story[body]').value).to eq(body)
  end

  scenario 'user attempts to edit another user\'s story' do
    tale
    user_sign_in(user2)
    click_link(tale.title)

    expect(page).to_not have_button('Edit Story')
  end
end
