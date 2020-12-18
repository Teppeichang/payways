require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '店舗情報の投稿' do
    it '写真とタグが入力されていなくても、店名と決済方式・お店に関する情報の両方が入力されていると投稿できる' do
      @post.image = nil
      @post.tag = ''
      expect(@post).to be_valid
    end
    it '店名が入力されていないと投稿できない' do
      @post.shop_name = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('店名を入力してください')
    end
    it '決済方式・お店に関する情報が入力されていないと投稿できない' do
      @post.explain = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('決済方式・お店に関する情報を入力してください')
    end
  end

  describe '投稿の編集' do
    it '写真とタグが入力されていなくても、店名と決済方式・お店に関する情報の両方が入力されていると投稿できる' do
      expect(@post).to be_valid
    end
    it '店名が入力されていないと投稿できない' do
      @post.shop_name = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('店名を入力してください')
    end
    it '決済方式・お店に関する情報が入力されていないと投稿できない' do
      @post.explain = nil
      @post.valid?
      expect(@post.errors.full_messages).to include('決済方式・お店に関する情報を入力してください')
    end
  end
end
