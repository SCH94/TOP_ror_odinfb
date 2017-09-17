require 'rails_helper'

describe 'Like management', type: :feature do

  before :example do
    @poster = create(:user)
    @liker = create(:user)
    @post = @poster.posts.create(title: "Title", body: "Body of post")
    create(:friendship, user_id: @liker.id, friend_id: @poster.id, accepted: true)

    log_in(@liker)
  end

  context 'liking a post' do
    scenario 'on the feed' do
      visit authenticated_root_path

      expect{ click_link 'Like' }.to change(@post.likes, :count).by 1
      expect(current_path).to eq authenticated_root_path
    end

    scenario 'on a profile' do
      visit user_path(@poster)

      expect{ click_link 'Like' }.to change(@post.likes, :count).by 1
      expect(current_path).to eq user_path(@poster)
    end
  end

  context 'unliking a post' do
    before :each do
      @liker.likes.create!(post_id: @post.id)
    end

    scenario 'on the feed' do
      visit authenticated_root_path
      
      expect{ click_link 'Unlike' }.to change(@post.likes, :count).by -1
      expect(current_path).to eq authenticated_root_path
    end

    scenario 'on a profile' do
      visit user_path(@poster)
      
      expect{ click_link 'Unlike' }.to change(@post.likes, :count).by -1
      expect(current_path).to eq user_path(@poster)
    end
  end
end