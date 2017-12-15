require 'rails_helper' 

describe CommentsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:test_post) { create(:post) }
  let(:test_comment) { create(:comment, user: current_user, post: test_post) }
  
  let(:valid_comment_params) {
    { comment: { body: test_comment.body },
      post_id: test_post,
      user_id: current_user                
    }    
  }
  let(:invalid_comment_params) {
    { comment: { body: "" },
      post_id: test_post,
      user_id: current_user                
    }    
  }
  let(:good_request) { post :create, params: valid_comment_params }
  let(:bad_request) { post :create, params: invalid_comment_params }

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new comment" do
        expect{ good_request }.to change(Comment, :count).by(1)
      end

      xit "redirects successfully" do
        expect(good_request).to have_http_status(300)
      end
    end

    context "with invalid params" do
      it "does not create a new comment" do
        expect{
          post :create, params: invalid_comment_params
        }.to_not change(Comment, :count)
      end
    end
  end
end