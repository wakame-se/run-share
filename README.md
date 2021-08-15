# README

## users

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_reading  | string  | null: false               |
| first_name_reading | string  | null: false               |
| birthday           | date    | null: false               |

### Association

- has_many :posts
- has_many :comments

## posts

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| map_link | text       | null: false                    |
| distance | integer    | null: false                    |
| course   | string     | null: false                    |
| slope    | string     | null: false                    |
| traffic  | string     | null: false                    |
| crowd    | string     | null: false                    |
| view     | string     | null: false                    |
| comment  | text       | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

# comments

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post
