require 'rails_helper'

describe Post do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  it "is invalid without an associated User" do
    expect(build(:post, user: nil)).to_not be_valid
  end
end
