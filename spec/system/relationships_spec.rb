require 'rails_helper'

RSpec.describe 'フォロー・フォロー解除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context 'ユーザーのフォロー' do
    it 'フォローボタンを押すとユーザーをフォローできる' do
      # ユーザー１でログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name = "commit"]').click
      # ユーザー２のページへ遷移する
      visit user_path(@user2)
      # フォローボタンをクリックし、ユーザー２をフォローする
      find('input[name="commit"]').click
      expect(page).to have_content('フォロワー1')
    end
  end

  context 'ユーザーのフォロー解除' do
    it 'フォロー後、再度フォローボタンを押すとユーザーのフォローを解除できる' do
      # ユーザー１でログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name = "commit"]').click
      # ユーザー２のページへ遷移する
      visit user_path(@user2)
      # フォローボタンをクリックし、ユーザー２をフォローする
      find('input[name="commit"]').click
      expect(page).to have_content('フォロワー 1')
      # フォローボタンを再度クリックし、ユーザー２のフォローを解除する
      find('input[name="commit"]').click
      expect(page).to have_content('フォロワー 0')
    end
  end
end
