require "rails_helper"

describe "Comment management", type: :feature do
  before :example do
    @poster = create(:confirmed_user)
    @commenter = create(:confirmed_user)
    @post = @poster.posts.create(title: "Title", body: "Body of post")
    create(:friendship, user_id: @commenter.id, friend_id: @poster.id, accepted: true)

    login_as(@commenter)
  end
  
  describe "viewing the comment form" do
    before :each do
      visit authenticated_root_path
      click_link "Comment"
    end

    it "displays a comment form" do
      expect(page).to have_selector("form")
    end
  
    it "displays a comment field" do
      expect(page).to have_selector("textarea")
    end
  
    it "displays a submit button" do
      expect(page).to have_css("input#comment-submit")
    end
  
    it "displays a cancel link" do
      expect(page).to have_link("Cancel")
    end
  end

  describe "commenting from the feed" do
    before :each do
      visit authenticated_root_path
      click_link "Comment"
      fill_in "Comment", with: Faker::VentureBros.quote
      click_button "Submit"
    end

    it "displays a confirmation" do
      expect(page).to have_css(".alert-notice")
    end

    it "returns the user back to the feed" do
      expect(current_path).to eq authenticated_root_path
    end
  end
    
  describe "commenting from another user's profile" do
    before :each do
      visit user_path(@poster)
      click_link "Comment"
      fill_in "Comment", with: Faker::VentureBros.quote
      click_button "Submit"
    end
    
    it "displays a confirmation" do
      expect(page).to have_css(".alert-notice")
    end
    
    it "returns the user back to the other user's profile" do
      expect(current_path).to eq user_path(@poster)
    end
  end

  describe "cancelling a comment" do
    context "from the feed" do
      it "returns the user back to the feed" do
        visit authenticated_root_path
        click_link "Comment"
        click_link "Cancel"

        expect(current_path).to eq authenticated_root_path
      end
    end

    context "from another user's profile" do
      it "returns the user back to the other user's profile" do
        visit user_path(@poster)
        click_link "Comment"
        click_link "Cancel"

        expect(current_path).to eq user_path(@poster)
      end
    end
  end
    
  describe "viewing a comment on a post", js: true do
    before :example do
      @comment = @post.comments.create(body: "This is a comment.", user_id: @commenter.id)
      visit authenticated_root_path
    end

    context "before toggling it into view" do
      it "does not display a comment's text" do
        expect(page).to_not have_content(@comment.body)
      end
    end

    
    context "after toggling it into view" do
      before :each do
        find("#toggle-button").click
      end

      it "displays a comment's text" do
        expect(page).to have_content(@comment.body)
      end
  
      it "displays a comment's author" do
        expect(page).to have_content(@comment.user_name)
      end
  
      it "diplays a comment's timestamp" do
        expect(page).to have_content(@comment.date_print)
      end
    end

    context "after toggling it out of view" do
      before :each do
        find("#toggle-button").click
        sleep 0.5
        find("#toggle-button").click
      end

      it "hides a comment's text" do
        expect(page).to_not have_content(@comment.body)
      end
    end
  end
end
