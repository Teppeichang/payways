# DB設計

## usersテーブル
| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| name                  | string | null: false |
| email                 | string | null: false |
| password              | string | null: false |
| password_confirmation | string | null: false |
## アソシエーション
- has_many :posts
- has_one_attached :image
- has_many :comments
- has_many :likes
- has_many :tags
- has_many :post_tag_relations


## postsテーブル
| Column         | Type    | Options                        |
| -------------- | ------- | ------------------------------ |
| user_id        | integer | null: false, foreign_key: true |
| shop_name      | string  | null: false                    |
| explain        | text    | null: false                    |
## アソシエーション
- belongs_to :user
- has_one_attached :image
- has_many :comments
- has_many :likes


## commentsテーブル
| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| post_id | integer | null: false, foreign_key: true |
| text    | text    |                                |
## アソシエーション
- belongs_to :user
- belongs_to :post

## likesテーブル
| Column  | Type    | Options           |
| ------- | ------- | ----------------- |
| user_id | integer | foreign_key: true |
| post_id | integer | foreign_key: true |
## アソシエーション
- belongs_to :user
- belongs_to :post
