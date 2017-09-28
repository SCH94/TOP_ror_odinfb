class User < ApplicationRecord
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, through: :received_friendships, source: :user
  
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  scope :all_except, -> (user) { where.not(id: user.id) }

  def friends
    active_friends | received_friends
  end

  def all_friendships
    self.friendships.where(accepted: true, user_id: self.id).or(self.received_friendships.where(accepted: true, friend_id: self.id))
  end

  def like!(post)
    self.likes.create!(post_id: post.id)
  end

  def unlike!(post)
    heart = self.likes.find_by_post_id(post.id)
  end

  def like?(post)
    self.likes.find_by_post_id(post.id)
  end

  def comment_on(post)
    self.comments.create!(post_id: post.id)
  end

  def feed
    Post.where("user_id IN (?) OR user_id = ?", active_friend_ids, id).order(created_at: :desc)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end