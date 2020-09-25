class Post < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :credit_card
  belongs_to_active_hash :e_money
  belongs_to_active_hash :code_pay
  with_options presence: true do
    validates :shop_name
    validates :credit_card_id
    validates :e_money_id
    validates :code_pay_id
  end
  
end
