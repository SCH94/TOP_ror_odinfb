require 'rails_helper'

describe 'Comment management', type: :feature do
  before :example do
    @poster = create(:user)
    @commenter = create(:user)
    @post = @poster.posts.create(title: "Title", body: "Body of post")
    create(:friendship, user_id: @commenter.id, friend_id: @poster.id, accepted: true)

    log_in(@commenter)
  end

  context 'commenting on a post' do
    scenario 'on the feed' do
      visit authenticated_root_path

      click_link('Comment')
      fill_in 'Comment', with: Faker::VentureBros.quote
      expect{ click_button 'Submit' }.to change(@post.comments, :count).by 1
      expect(current_path).to eq authenticated_root_path
    end

    scenario 'on a profile' do
      visit user_path(@poster)
      
      click_link('Comment')
      fill_in 'Comment', with: Faker::VentureBros.quote
      expect{ click_button 'Submit' }.to change(@post.comments, :count).by 1
      expect(current_path).to eq user_path(@poster)
    end
  end
end
