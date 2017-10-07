require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#date_print' do
    it "formats the comment's date" do 
      comment = Comment.new
      comment.created_at = DateTime.new(2001,2,3,11,56,00,Rational(-5, 24))
      expect(comment.date_print).to eq ("Feb 3 2001 at 11:56AM")
    end
  end
end
