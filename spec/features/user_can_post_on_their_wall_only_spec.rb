require_relative './sign_up_helper'
feature 'Post on a wall' do
  scenario 'User posts on their wall and doesn\'t appear on news feed' do
    registration
    visit('/users/1')
    click_link "New post"
    fill_in "post[message]", with: "Post for wall only"
    click_button "Submit"
    visit('/users/1')
    expect(page).to have_content('Post for wall only')
    visit('/posts')
    expect(page).not_to have_content('Post for wall only')
  end
end
