require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿機能' do
    it 'コメントが入力されていると投稿できる' do
      expect(@comment).to be_valid
    end
    it 'コメントが入力されていないと投稿できない' do
      @comment.text = ""
      @comment.valid?
      binding.pry
      expect(@comment.errors.full_messages).to include("コメントを入力してください")
    end
  end
end
