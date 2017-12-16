require 'rails_helper'

describe 'Post management', type: :feature do
  let(:poster) { create(:confirmed_user) }
  
  before :example do
    login_as poster
  end

  context "from the feed" do
    before :each do
      visit authenticated_root_path
      click_on "Create a post"
      fill_in 'Title', with: 'A new title'
      fill_in 'Post', with: 'A new post.'
    end

    describe "creating a post" do      
      it "displays a confirmation" do
        click_on "Submit"  
        expect(page).to have_css(".alert-notice")
      end

      it "redirects a user back to the feed" do
        click_on "Submit"  
        expect(current_path).to eq authenticated_root_path
      end
    end

    describe "cancelling a post" do
      it "redirects a user back to the feed" do
        click_on "Cancel"
        expect(current_path).to eq authenticated_root_path
      end
    end
  end

  context "from a user's profile" do
    before :each do
      visit user_path poster
      click_on "Create a post"
      fill_in 'Title', with: 'A new title'
      fill_in 'Post', with: 'A new post.'
    end

    describe "creating a post" do
      it "displays a confirmation" do
        click_on "Submit"
        expect(page).to have_css(".alert-notice")
      end
  
      it "redirects a user back to their profile" do
        click_on "Submit"
        expect(current_path).to eq user_path poster
      end
    end

    describe "cancelling a post" do
      it "redirects a user back to their profile" do
        click_on "Cancel"
        expect(current_path).to eq user_path poster
      end
    end
  end
end