class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  geocoded_by :shop_name
  after_validation :geocode, if: :shop_name_changed?

  with_options presence: true do
    validates :shop_name
    validates :explain, length: { maximum: 300 }
  end

  # 検索機能
  def self.search(search)
    if search != ''
      Post.where('shop_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  # いいね！に関する通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(post_id: id, visited_id: user_id, action: 'like')
    notification.save if notification.valid?
  end

  # コメントに関する通知
  def create_notification_comment(current_user, comment_id)
    commented_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    commented_ids.each do |commented_id|
      save_notification_comment(current_user, comment_id, commented_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id) if commented_ids.blank?
  end

  # コメントに関する通知（１つの投稿に複数コメントされることがあるので、１つの投稿に複数回通知）
  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(post_id: id, comment_id: comment_id, visited_id: visited_id, action: 'comment')
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  private

  # postsテーブルのshop_nameを元に、GoogleMaps API（geocoder）で緯度経度を計算する処理
  def geocode
    require 'net/http'
    # require 'addressable/uri'
    uri = Addressable::URI.encode('https://maps.googleapis.com/maps/api/geocode/json?address=' + shop_name + '&key=' + ENV['MAPS_API_KEY'])
    res = Net::HTTP.get_response(URI.parse(uri))
    response = JSON.parse(res.body)
    if response['status'] == 'OK'
      self.latitude = response['results'][0]['geometry']['location']['lat']
      self.longitude = response['results'][0]['geometry']['location']['lng']
    else
      self.latitude = 1
      self.longitude = 1
    end
  end
end
