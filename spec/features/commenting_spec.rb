require 'rails_helper'

describe 'Comment management', type: :feature do

  let!(:poster) { create(:user) }
  let!(:post) { poster.posts.create(title: "Title", body: "Body of post") }
  let!(:commenter) { create(:user) }
  let!(:friendship ) { create(:friendship, user_id: commenter.id, friend_id: poster.id, accepted: true) }

  scenario 'commenting on a feed post' do
    log_in(commenter)

    visit authenticated_root_path

    click_link('Comment')
    fill_in 'Comment', with: Faker::VentureBros.quote
    expect{ click_button 'Submit' }.to change(Comment, :count).by 1
    expect(current_path).to eq(authenticated_root_path)
  end

  scenario 'commenting on a profile post' do
    log_in(commenter)

    visit user_path(poster)
    
    click_link('Comment')
    fill_in 'Comment', with: Faker::VentureBros.quote
    expect{ click_button 'Submit' }.to change(Comment, :count).by 1
    expect(current_path).to eq user_path(poster)
  end
end
