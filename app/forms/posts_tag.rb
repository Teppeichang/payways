class PostsTag
  include ActiveModel::Model
  attr_accessor :image, :shop_name, :explain, :name, :user_id

  validates :shop_name, presence: true
  validates :explain, presence: true
  validates :name, presence: true

  def save
    post = Post.create(image: image, shop_name: shop_name, explain: explain, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end

end