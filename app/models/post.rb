class Post < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :credit_card
  belongs_to_active_hash :e_money
  belongs_to_active_hash :code_pay
  has_one_attached :image

  with_options presence: true do
    validates :shop_name
    validates :credit_card_id
    validates :e_money_id
    validates :code_pay_id
  end

  def self.search(search)
    if search != ""
      Post.where('shop_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
  
end
