require 'rails_helper'

describe 'Post management', type: :feature do
  before :example do
    @user = create(:user)
    log_in(@user)
  end

  context 'from the feed' do
    scenario 'creating a post' do
      visit authenticated_root_path
      click_link 'Create post'
      expect{
        fill_in 'Title', with: 'A new post'
        fill_in 'Post', with: 'This is a brief, test post.'
        click_button 'Submit'                        
      }.to change(Post, :count).by 1
      expect(current_path).to eq authenticated_root_path
      expect(page).to have_content 'Post was successfully created'
    end

    scenario 'cancelling a post' do
      visit authenticated_root_path
      click_link 'Create post'
      click_link 'Cancel'
      expect(current_path).to eq authenticated_root_path
    end
  end

  context 'from a profile' do
    scenario 'creating a post' do
      visit user_path(@user)
      click_link 'Create post'
      expect{
        fill_in 'Title', with: 'A new post'
        fill_in 'Post', with: 'This is a brief, test post.'
        click_button 'Submit'                        
      }.to change(Post, :count).by 1
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content 'Post was successfully created'
    end

    scenario 'cancelling a post' do
      visit user_path(@user)
      click_link 'Create post'
      click_link 'Cancel'
      expect(current_path).to eq user_path(@user)
    end
  end
end