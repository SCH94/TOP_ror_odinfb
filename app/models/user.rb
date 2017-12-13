class User < ApplicationRecord
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :requested_friends,
    -> { where(friendships: { accepted: true }) },
    through: :friendships,
    source: :friend
  
  has_many :awaiting_friendships,
    -> { where(friendships: { accepted: false}) },
    through: :friendships,
    source: :friend

  has_many :received_friends,
    -> { where(friendships: { accepted: true }) },
    through: :received_friendships,
    source: :user
  
  has_many :pending_friendships,
    -> { where(friendships: { accepted: false}) },
    through: :received_friendships,
    source: :user

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :timeoutable, :omniauth_providers => [:facebook, :google_oauth2]

  scope :all_except, -> (user) { where.not(id: user.id) }

  def accepted_friends
    requested_friends | received_friends
  end

  def accepted_friend_ids
    accepted_friends.map(&:id)
  end

  def accepted_friendships
    friendships.where(accepted: true, user_id: id).or(received_friendships.where(accepted: true, friend_id: id))
  end

  def feed
    Post.where(user_id: [accepted_friend_ids, id].flatten).order(created_at: :desc).includes(:comments, :user)
  end

  def liked?(post)
    likes.find_by_post_id(post)
  end

  def self.from_omniauth(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.email = auth['info']['email']
      user.password = Devise.friendly_token[0,20]
      user.name = auth['info']['name']
    end
  end
end
