require 'rails_helper'

describe 'Friend management', type: :feature do

  before :example do
    @sender = create(:user)
    @receiver = create(:user)
  end
  
  scenario 'sending a friend request' do
    log_in @sender
    visit authenticated_root_path
    click_link 'See all users'
    expect(current_path).to eq users_path
    expect{
      find_link('Request Friend').click
    }.to change(Friendship, :count).by 1
    expect(page).to have_content 'Added friend.'
    expect(page).to have_content 'Already requested'
  end

  scenario 'accepting a friend request' do
    @sender.friendships.create(friend_id: @receiver.id)
    log_in @receiver
    visit user_path @receiver
    within('#friends-pending'){ expect(page).to have_content @sender.name }
    click_on 'Accept'
    expect(current_path).to eq user_path(@receiver)
    within('#friends-active'){ expect(page).to have_content @sender.name }
    expect(page).to have_content "Successfully confirmed friend!"
  end

  xscenario 'rejecting a friend request' do
    #code
  end

  scenario 'deleting a friend' do
    create(:friendship, user_id: @sender.id, friend_id: @receiver.id)
    log_in @sender
    visit user_path @sender
    within('#friends-active'){ expect(page).to have_content @receiver.name }
    click_on 'Remove'
    expect(current_path).to eq user_path @sender
    within('#friends-active'){ expect(page).to_not have_content @receiver.name }
  end
end