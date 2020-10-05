class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations


  def self.search(search)
    if search != ""
      Post.where('shop_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
  
end
