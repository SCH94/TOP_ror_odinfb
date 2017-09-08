require 'rails_helper'

describe 'Like management', type: :feature do

  let!(:poster) { create(:user) }
  let!(:post) { poster.posts.create(title: "Title", body: "Body of post") }
  let!(:liker) { create(:user) }

  scenario 'liking a post' do
    visit root_path
    fill_in 'Email', with: liker.email
    fill_in 'Password', with: liker.password
    click_button 'Log in'

    visit user_path(poster)

    expect{ click_button 'Like' }.to change(Like, :count).by 1
    expect(current_path).to eq user_path(poster)
  end

  scenario 'unliking a post' do
    liker.likes.create!(post_id: post.id)

    visit root_path
    fill_in 'Email', with: liker.email
    fill_in 'Password', with: liker.password
    click_button 'Log in'

    visit user_path(poster)

    expect{ click_button 'Unlike' }.to change(post.likes, :count).by -1
    expect(current_path).to eq user_path(poster)
  end
end