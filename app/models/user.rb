class User < ApplicationRecord
  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, through: :received_friendships, source: :user
  
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :all_except, -> (user) { where.not(id: user.id) }

  def friends
    active_friends | received_friends
  end

  def all_friendships
    self.friendships.where(accepted: true, user_id: self.id).or(self.received_friendships.where(accepted: true, friend_id: self.id))
  end
end