class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one_attached :image
  has_many :likes

  with_options presence: true do
    validates :shop_name
    validates :explain
  end

  def self.search(search)
    if search != ""
      Post.where('shop_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
  
end
