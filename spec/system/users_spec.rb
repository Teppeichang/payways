require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができる時' do
    it '正しい情報を入力するとユーザー新規登録ができる' do
      # トップページに遷移する
      visit root_path
      # トップページに「新規登録」ボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # ユーザー新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "user_name", with: @user.name 
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password_confirmation
      # 「登録」ボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name = "commit"]').click  
      }.to change {User.count}.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
  context 'ユーザー新規登録ができない時' do
    it '正しい情報が入力されないとユーザー新規登録ができない' do
      # トップページに遷移する
      visit root_path
      # トップページに「新規登録」ボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # ユーザー新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を正しく入力しない
      fill_in "user_name", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      fill_in "user_password_confirmation", with: ""
      # 「登録」ボタンを押してもユーザーモデルのカウントが上がらない
      expect{
        find('input[name = "commit"]').click  
      }.to change {User.count}.by(0)
      # ユーザー新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできる時' do
    it '保存されているユーザーの情報と合致すればログインできる' do
      # トップページに遷移する
      visit root_path
      # トップページに「ログイン」ボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を正しく入力する
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      # 「ログイン」ボタンをクリックする
      find('input[name = "commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 「新規登録」「ログイン」ボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ログインできない時' do
    it '保存されているユーザーの情報と合致しないとログインできない' do
      # トップページに遷移する
      visit root_path
      # トップページに「ログイン」ボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を正しく入力しない
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      # 「ログイン」ボタンをクリックする
      find('input[name = "commit"]').click
      # ログインページに遷移することを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ユーザー情報の編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザー情報が編集できる時' do
    it '編集するユーザー情報を正しく入力するとユーザー情報を編集できる' do
      # ログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      find('input[name = "commit"]').click
      expect(current_path).to eq root_path
      # ユーザーページへ遷移する
      visit user_path(@user.id)
      # 「ユーザー情報の編集」ボタンがあることを確認する
      expect(page).to have_content("ユーザー情報の編集")
      # ユーザー情報編集ページへ遷移する
      visit edit_user_path(@user.id)
      # 編集するユーザー情報を正しく入力する
      fill_in "user_name", with: @user.name
      fill_in "user_email", with: @user.email
      # 「更新」ボタンをクリックする
      find('input[name = "commit"]').click
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
end
