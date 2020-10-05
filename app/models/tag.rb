class Tag < ApplicationRecord
  has_many :post_tag_relations
  has_many :posts, through: :post_tag_relations

  validates :name, uniqueness: true
  
end
