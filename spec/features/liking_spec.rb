require 'rails_helper'

describe 'Like management', type: :feature do
  before :example do
    @poster = create(:user)
    @liker = create(:user)
    @post = @poster.posts.create(title: "Title", body: "Body of post")
    create(:friendship, user_id: @liker.id, friend_id: @poster.id, accepted: true)

    log_in(@liker)
  end

  context 'from the feed' do
    scenario 'liking a post' do
      visit authenticated_root_path
      expect{ click_link 'Like' }.to change(@post.likes, :count).by 1
      expect(current_path).to eq authenticated_root_path
    end

    scenario 'unliking a post' do
      @liker.likes.create!(post_id: @post.id)
      visit authenticated_root_path
      expect{ click_link 'Unlike' }.to change(@post.likes, :count).by -1
      expect(current_path).to eq authenticated_root_path
    end
  end

  context 'from a profile' do
    scenario 'liking a post' do
      visit user_path(@poster)
      expect{ click_link 'Like' }.to change(@post.likes, :count).by 1
      expect(current_path).to eq user_path(@poster)
    end

    scenario 'unliking a post' do
      @liker.likes.create!(post_id: @post.id)
      visit user_path(@poster)
      expect{ click_link 'Unlike' }.to change(@post.likes, :count).by -1
      expect(current_path).to eq user_path(@poster)
    end
  end
end