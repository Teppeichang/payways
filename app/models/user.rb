class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_one_attached :image
  has_many :likes

  validates :name, presence: true, format: {with: /[0-9a-zA-Z]/, message: "を正しく入力してください"}
  validates :email, presence: true
  
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "GUEST"
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
