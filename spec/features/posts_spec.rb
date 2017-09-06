require 'rails_helper'

describe 'Post management', type: :feature do
  scenario 'creating a new post' do
    user = create(:user)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit user_path(user)
    click_link 'Create post'

    expect{
      fill_in 'Title', with: 'A new post'
      fill_in 'Post', with: 'This is a brief, test post.'
      click_button 'Create Post'                  
    }.to change(Post, :count).by 1
    expect(current_path).to eq user_path(user)
    expect(page).to have_content "Post was successfully created"
  end
end