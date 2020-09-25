# DB設計

## usersテーブル
| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| name                  | string | null: false |
| email                 | string | null: false |
| password              | string | null: false |
| password_confirmation | string | null: false |
## アソシエーション
has_many :posts
has_many :comments
has_many :bookmarks

## postsテーブル
| Column      | Type    | Options                        |
| ----------- | ------- | ------------------------------ |
| user_id     | integer | null: false, foreign_key: true |
| shop_name   | string  | null: false                    |
| credit_card | integer | null: false                    |
| e_money     | integer | null: false                    |
| code_pay    | integer | null: false                    |
| explain     | text    |                                |
## アソシエーション
belongs_to :user
has_many :bookmarks

## commentsテーブル
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| post_id | integer | null: false, foreign_key: true |
## アソシエーション
belongs_to :user
belongs_to :post

## bookmarksテーブル
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| post_id | integer | null: false, foreign_key: true |
## アソシエーション
belongs_to :user
belongs_to :post
