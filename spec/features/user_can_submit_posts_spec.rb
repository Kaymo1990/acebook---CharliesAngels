require 'rails_helper'
require_relative './sign_up_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    registration
    create_post
    expect(page).to have_content("Hi")
  end

  scenario "Can submit multi-line posts and view them" do
    registration
    create_post_multi_line
    expect(page.html).to include("Line one\n<br />Line Two")
  end

  scenario "Can submit a post to a wall which redirect back to that wall" do
    registration
    visit "users/1"
    click_link "New post"
    fill_in "post[message]", with: "Hi"
    click_button "Submit"
    expect(page).to have_current_path(user_path(1))
    expect(page).to have_content("Hi")
  end

  scenario "Can submit a post from the newsfeed and be redirected back to the newsfeed" do
    registration
    create_post
    expect(page).to have_current_path(posts_path)
    expect(page).to have_content("Hi")
  end

end
