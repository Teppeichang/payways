require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'すべての情報が正しく入力されているとユーザー登録できる' do
      expect(@user).to be_valid
    end
    it 'ユーザー名が半角英数字でないと登録できない' do
      @user.name = "あいうえお"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name is invalid")
    end
    it 'メールアドレスが入力されていないと登録できない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'パスワードが６文字未満だと登録できない' do
      @user.password = "aaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワード（確認）がパスワードと合致していないと登録できない' do
      @user.password = "aaaaaa"
      @user.password_confirmation = "bbbbbb"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe 'ユーザーログイン' do
    it 'すべての情報が正しく入力されているとログインできる' do
      expect(@user).to be_valid
    end
    it 'メールアドレスが入力されていないとログインできない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'パスワードが入力されていないとログインできない' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
  end
end
