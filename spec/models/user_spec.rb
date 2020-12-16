require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'すべての情報が正しく入力されているとユーザー登録できる' do
      expect(@user).to be_valid
    end
    it 'ユーザー名が入力されてないと登録できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('ユーザー名を正しく入力してください')
    end
    it 'メールアドレスが入力されていないと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
    end
    it 'パスワードが入力されていないと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'パスワードが６文字未満だと登録できない' do
      @user.password = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワード（確認）がパスワードと合致していないと登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'bbbbbb'
      @user.valid?
      expect(@user.errors.full_messages).to include('確認用パスワードとパスワードの入力が一致しません')
    end
  end

  describe 'ユーザーログイン' do
    it 'すべての情報が正しく入力されているとログインできる' do
      expect(@user).to be_valid
    end
    it 'メールアドレスが入力されていないとログインできない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
    end
    it 'パスワードが入力されていないとログインできない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
  end

  describe 'ユーザー情報編集' do
    it 'ユーザー名とメールアドレスが入力できていると情報を更新できる' do
      expect(@user).to be_valid
    end
    it 'ユーザー名が入力されていないと情報を更新できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
    end
    it 'メールアドレスが入力されていないと情報を更新できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
    end
  end
end
