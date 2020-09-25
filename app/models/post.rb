class Post < ApplicationRecord
  with_options presence: true do
    validates :shop_name
    validates :credit_card_id
    validates :e_money_id
    validates :code_pay_id
  end
end
