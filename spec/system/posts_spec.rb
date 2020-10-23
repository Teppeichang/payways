require 'rails_helper'

RSpec.describe "店舗情報の投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @posts_shop_name = Faker::Restaurant.name
    @posts_explain = Faker::Lorem.word
  end

  context '投稿ができる時' do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      find('input[name = "commit"]').click
      # 「新規投稿」ボタンがある
      expect(page).to have_content("新規投稿")
      # 新規投稿ページに遷移する
      visit new_post_path
      # 投稿フォームに情報を入力する
      fill_in "post_shop_name", with: @posts_shop_name
      fill_in "post_explain", with: @posts_explain
      # 投稿するとPostモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click  
      }.to change {Post.count}.by(1)
      # トップページに遷移する
      visit posts_path
      # トップページに先程投稿した内容が表示されていることを確認する
      expect(page).to have_content(@posts_shop_name)
      expect(page).to have_content(@posts_explain)
    end
  end
  context '投稿ができない時' do
    it 'ログインしていないユーザーは投稿できない' do
      # トップページに遷移する
      visit root_path
      # 「新規投稿」ボタン（新規投稿ページにリンク）がないことを確認する
      expect(page).to have_no_content("新規投稿")
    end
  end
end

RSpec.describe "投稿の編集", type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿の編集ができる時' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # 投稿1を投稿したユーザーでログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @post1.user.email
      fill_in "user_password", with: @post1.user.password
      find('input[name = "commit"]').click
      # 編集ページに遷移する
      visit edit_post_path(@post1)
      # 投稿1に「編集」ボタンがあることを確認する
      expect(page).to have_content("編集")
      # 投稿内容を編集する
      fill_in "post_shop_name", with: "#{@post1.shop_name}+編集したテキスト"
      fill_in "post_explain", with: "#{@post1.explain}+編集したテキスト"
      # 編集してもPostモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # （編集後）トップページに遷移する
      visit posts_path
      # トップページには先程編集した投稿が存在する
      expect(page).to have_content("#{@post1.shop_name}+編集したテキスト")
      expect(page).to have_content("#{@post1.explain}+編集したテキスト")
    end
  end
  context '投稿の編集ができない時' do
    it 'ログインしたユーザーは自分以外の投稿の編集ページに遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @post1.user.email
      fill_in "user_password", with: @post1.user.password
      find('input[name = "commit"]').click
      # 投稿2のページに遷移する
      visit post_path(@post2)
      # 投稿2のページに「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
    it 'ログインしないと投稿の編集ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 非ログイン時のトップページに投稿が表示されていないことを確認する
      expect(page).to have_no_content(@post1)
      expect(page).to have_no_content(@post2)
    end
  end
end

RSpec.describe '投稿の削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿の削除ができる時' do
    it 'ログインしたユーザーは自分の投稿を削除することができる' do
      # 投稿1を投稿したユーザーでログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @post1.user.email
      fill_in "user_password", with: @post1.user.password
      find('input[name = "commit"]').click
      # 投稿詳細ページに遷移する
      visit post_path(@post1)
      # 投稿に「削除」ボタンがあることを確認する
      expect(page).to have_content("削除")
      # 投稿を削除するとPostモデルのカウントが1減る
      expect{
        find_link("削除", href: post_path(@post1)).click
      }.to change { Post.count }.by(-1)
      # （削除後）トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # トップページに削除した投稿1が存在しないことを確認する
      expect(page).to have_no_content(@post1)
    end
  end
  context '投稿の削除ができない時' do
    it 'ログインしたユーザーは自分以外の投稿を削除できない' do
      # 投稿1を投稿したユーザーでログインする
      visit root_path
      expect(page).to have_content("ログイン")
      visit new_user_session_path
      fill_in "user_email", with: @post1.user.email
      fill_in "user_password", with: @post1.user.password
      find('input[name = "commit"]').click
      # 投稿2の詳細ページへ遷移する
      visit post_path(@post2)
      # 投稿2に「削除」ボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
    it 'ログインしていないと投稿の削除ができない' do
      # トップページに遷移する
      visit root_path
      # 非ログイン時のトップページに投稿が表示されていないことを確認する
      expect(page).to have_no_content(@post1)
      expect(page).to have_no_content(@post2)
    end
  end
end

RSpec.describe '投稿詳細', type: :system do
  before do
    @post = FactoryBot.create(:post)
  end

  it 'ログインしているユーザーは投稿詳細にコメント欄が表示される' do
    # ログインする
    visit root_path
    expect(page).to have_content("ログイン")
    visit new_user_session_path
    fill_in "user_email", with: @post.user.email
    fill_in "user_password", with: @post.user.password
    find('input[name = "commit"]').click
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページにコメント一覧とコメント記入欄・コメント投稿ボタンが存在する
    expect(page).to have_content("コメント一覧")
    expect(page).to have_selector "textarea"
    expect(page).to have_selector "input"
  end
  it 'ログインしていない状態でも投稿詳細を閲覧できるがコメントはできない' do
    # トップページへ遷移する
    visit root_path
    # 「検索」ボタンがあることを確認する
    expect(page).to have_content("検索")
    # 検索結果ページへ遷移する
    visit search_posts_path
    # 投稿詳細ページへ遷移する
    visit post_path(@post)
    # 投稿詳細ページにコメント一覧とコメント記入欄・コメント投稿ボタンがないことを確認する
    expect(page).to have_no_content("コメント一覧")
    expect(page).to have_no_selector "textarea"
    expect(page).to have_no_selector "input"
  end
  it 'ログインしているユーザーは投稿詳細に「いいね！」が表示される' do
    # ログインする
    visit root_path
    expect(page).to have_content("ログイン")
    visit new_user_session_path
    fill_in "user_email", with: @post.user.email
    fill_in "user_password", with: @post.user.password
    find('input[name = "commit"]').click
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページに「いいね！」ボタンが存在する
    expect(page).to have_content("いいね！")
    # 「いいね！」をクリックするとLikeモデルのカウントが1上がる
    expect{
      find_link("いいね！", href: create_like_path(@post)).click
    }.to change { Like.count }.by(1)
    # （「いいね！」ボタンクリック後）表示が「いいね！済み」になることを確認する
    expect(page).to have_content("いいね！済み")
    # 「いいね！済み」をクリックするとLikeモデルのカウントが1減る
    expect{
      find_link("いいね！済み", href: destroy_like_path(@post)).click
    }.to change { Like.count }.by(-1)
  end
  it 'ログインしていない状態でも投稿詳細を閲覧できるが「いいね！」はできない' do
    # トップページへ遷移する
    visit root_path
    # 「検索」ボタンがあることを確認する
    expect(page).to have_content("検索")
    # 検索結果ページへ遷移する
    visit search_posts_path
    # 投稿詳細ページへ遷移する
    visit post_path(@post)
    # 投稿詳細ページにコメント一覧とコメント記入欄・コメント投稿ボタンがないことを確認する
    expect(page).to have_no_content("いいね！")
  end
end
