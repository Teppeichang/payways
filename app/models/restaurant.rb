class Restaurant < ApplicationRecord
  # scope :sorted, -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :restaurant_id, uniqueness: true
  validates :credit_card, null: false
  validates :e_money, null: false
  # geocoded_by :address
  # after_validation :geocode
  scope :search, -> (search_params) do
    # search_paramsが空の場合以降の処理を行わない。
    # >> {}.blank?
    # => true
    return if search_params.blank?

    # パラメータを指定して検索を実行する
    name_like(search_params[:name])
  end
  # nameが存在する場合、nameをlike検索する
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }

end
