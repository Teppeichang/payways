class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_one_attached :image
  has_many :likes

  validates :name, presence: true, format: {with: /[0-9a-zA-Z]/}
  validates :email, presence: true
  validates :password, length: {minimum: 6}
  
  def liked_by?(post_id)
    likes.where(post_id: post_id).exists?
  end

end
