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
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| content | text    | null: false                    |
## アソシエーション
belongs_to :user
has_many :bookmarks

## commentsテーブル
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| content | text    | null: false                    |
## アソシエーション
belongs_to :user

## bookmarksテーブル
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| post_id | integer | null: false, foreign_key: true |
## アソシエーション
belongs_to :user
belongs_to :post
