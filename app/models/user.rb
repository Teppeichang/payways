class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :posts
  has_many :comments
  has_one_attached :image
  has_many :likes
  has_many :like_posts, through: :likes, source: :post
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # validates :name, presence: true, format: {with: /[0-9a-zA-Z]/, message: "を正しく入力してください"}
  # validates :email, presence: true
  
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
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.prefecture_id = 1
    end
  end

end
