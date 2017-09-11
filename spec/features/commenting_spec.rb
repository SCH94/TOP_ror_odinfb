require 'rails_helper'

describe 'Comment management', type: :feature do

  let!(:poster) { create(:user) }
  let!(:post) { poster.posts.create(title: "Title", body: "Body of post") }
  let!(:commenter) { create(:user) }

  scenario 'liking a post' do
    visit root_path
    fill_in 'Email', with: commenter.email
    fill_in 'Password', with: commenter.password
    click_button 'Log in'

    visit user_path(poster)

    click_link 'Write a comment'
    fill_in 'Comment', with: Faker::VentureBros.quote
    expect{ click_button 'Submit' }.to change(Comment, :count).by 1
    expect(current_path).to eq user_path(poster)
  end
end
