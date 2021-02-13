## Payways
![payways_top](https://user-images.githubusercontent.com/65349790/95150922-58d0de80-07c4-11eb-84bb-90eeded2538b.jpg)

## 概要
キャッシュレス生活者に向けた店舗検索・情報共有サービスとなっております。
検索ツールとしても、SNSとしても、2つの使い方ができるアプリケーションです。
2020年1月から始めたプログラミング学習の積み上げを元に、ポートフォリオとして作成したものです。

## URL
※就職活動終了に伴い公開停止。


## なぜこのアプリケーションを作ったか
私は普段キャッシュレス生活をしており、小銭や紙幣ではなく、カードを持ち歩きます。ゆえに
「ふと立ち寄ったお店が現金決済しか対応しておらず、会計時にコンビニのATMを探すはめになる」
というちょっとした失敗体験をしました。
この自身の失敗体験をもとに、「キャッシュレスで生活している人がふとお店に立ち寄る前に、事前に
対応する支払い(Pay)方法(Way)をすぐ調べられたら、自分と同じ思いをするような人が減るのでは」
という思いからこの「Payways」を作りました。

## 使用技術
- フロントエンド
    - JavaScript
    - jQuery(ver 3.5.1)
    - Bootstrap(ver 4.3.1)

- バックエンド
    - Ruby 2.7.1
    - Ruby on Rails 6.0.3.3

- Web API
    - GoogleMaps API(Maps JavaScript API,Places API,Geocoding API,Geolocation API)

- インフラ(開発環境)
    - Docker(ver19.03.13)
    - docker-compose(ver1.27.4)

- インフラ(本番環境)
    - AWS(S3,VPC,EC2,Route53,ACM,ELB)
    - Nginx
    - Unicorn

- その他使用技術・ツール
    - Capistranoによる自動デプロイ
    - CircleCIによるCI/CDパイプライン構築
    - 常時SSL化
    - レスポンシブデザイン対応
    - RSpec
    - Rubocop
    - GitHub

## インフラ構成
![payways_インフラ図](https://user-images.githubusercontent.com/65349790/102466110-e2890c00-4091-11eb-96f0-8738d252acbc.png)

## DB設計
![payways_er_diagram](https://user-images.githubusercontent.com/65349790/98211877-11d23680-1f86-11eb-8829-539b811bf15b.png)

## アプリケーションの機能
- 検索機能(Ransack)
- 検索結果表示画面にページネーションを実装(kaminari)
- ユーザーログイン/登録/退会機能(ログイン・登録はdevise)
- ゲストログイン機能
- Google/Twitter/Facebook認証(OmniAuth)
- ユーザープロフィール編集機能
- 店舗情報の投稿のCRUD機能ととタグ付け(タグ付け機能はacts-as-taggable-onで実装)
- 投稿に対する「いいね！」機能(ajax)
- 投稿に対するコメント投稿機能(ajax)
- 画像投稿機能(ajaxによるプレビュー付き)
- フォロー/フォロー解除機能(ajax)
- コメント/いいね！/フォローの通知機能
- 投稿された店舗情報に基づいたGoogle Mapでの位置表示(GoogleMaps API)

## 開発において意識したこと
- 全体的に使用方法がわかりやすい、シンプルなUIデザインを心がけました。
- 「ふとお店に立ち寄る前にすぐ調べられる」よう、検索機能はログイン/ユーザー登録せずとも使えるようにしました。
- 冒頭に挙げた自身の失敗体験をもとに、同じ思いをする人を減らすよう「課題解決」を意識して作成しました。
- 「映え」や「いいね！」を好むSNSユーザーの使用も想定し、画像投稿・タグ付け、投稿に対する「いいね！」機能を実装しました。
- 現場での開発を想定し、GitHubを使用してこまめなcommitやissue管理を行いました。
