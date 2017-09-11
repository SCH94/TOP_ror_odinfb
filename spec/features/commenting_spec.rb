require 'rails_helper'

describe 'Comment management', type: :feature do

  let!(:poster) { create(:user) }
  let!(:post) { poster.posts.create(title: "Title", body: "Body of post") }
  let!(:commenter) { create(:user) }

  scenario 'commenting on a post' do
    log_in(commenter)

    visit user_path(poster)

    click_link 'Write a comment'
    fill_in 'Comment', with: Faker::VentureBros.quote
    expect{ click_button 'Submit' }.to change(Comment, :count).by 1
    expect(current_path).to eq user_path(poster)
  end
end
