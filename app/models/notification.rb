class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, foreign_key: 'visiter_id', class_name: 'User', optional: true
  belongs_to :visited, foreign_key: 'visited_id', class_name: 'User', optional: true
end
