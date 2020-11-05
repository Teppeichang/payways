class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter facebook]
  has_many :posts
  has_many :comments
  has_one_attached :image
  has_many :likes
  has_many :like_posts, through: :likes, source: :post
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship"
  has_many :followers, through: :follower_relationships
  has_many :active_notifications, foreign_key: "visiter_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key: "visited_id", class_name: "Notification", dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "GUEST"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0,20]
      user.prefecture_id = 1
    end
  end

  # フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # フォローする時のメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォローを解除する時のメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action =?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
      notification.save if notification.valid?
    end
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
