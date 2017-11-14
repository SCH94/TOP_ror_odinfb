class Post < ApplicationRecord
  belongs_to :user
  delegate :name, to: :user, prefix: :author

  has_many :likes, dependent: :destroy
  delegate :count, to: :likes, prefix: true

  has_many :comments, dependent: :destroy

  validates_presence_of :body
end
