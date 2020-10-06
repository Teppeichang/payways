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
      expect(@user.errors.full_messages).to include()
    end
    it 'メールアドレスが入力されていないと登録できない' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include()
    end
    it 'パスワードが６文字未満だと登録できない' do
      @user.password = "aaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include()
    end
    it 'パスワード（確認）がパスワードと合致していないと登録できない' do
      @user.password = "aaaaaa"
      @user.password_confirmation = "bbbbbb"
      @user.valid?
      expect(@user.errors.full_messages).to include()
    end
  end
end
