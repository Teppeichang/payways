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
    validates :explain
  end

  # 検索機能
  def self.search(search)
    if search != ""
      Post.where('shop_name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  private

  # postsテーブルのshop_nameを元に、GoogleMaps API（geocoder）で緯度経度を計算する処理
  def geocode
    require 'net/http'
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.shop_name+"&key="+ENV['MAPS_API_KEY'])
    res = Net::HTTP.get_response(URI.parse(uri))
    response = JSON.parse(res.body)
    if response["status"] == "OK"
      self.latitude = response["results"][0]["geometry"]["location"]["lat"]
      self.longitude = response["results"][0]["geometry"]["location"]["lng"]
    else
      self.latitude = 1
      self.longitude = 1
    end
  end
  
end
