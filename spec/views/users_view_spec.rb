require 'rails_helper'

describe 'Users view', type: :view do
  describe "users/index.html.erb" do
    before :each do
      @user = create(:confirmed_user)
      login_as(@user)
    end

    context "when there are more than 10 users" do
      it "displays pagination links" do
        create_list(:confirmed_user, 11)
        visit authenticated_root_path
        click_link 'See all users'
        expect(page).to have_css("div.pagination")
      end
    end

    context "when there are less 10 or less users" do
      it "does not display pagination links" do
        create_list(:confirmed_user, 9)
        visit authenticated_root_path
        click_link 'See all users'
        expect(page).to_not have_css("div.pagination")
      end
    end

  end
end