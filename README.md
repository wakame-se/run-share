# README
## アプリケーション名
- RunShare

## 概要
本アプリは、ランニングやウォーキングのコースを共有できるアプリケーションです。利用者が思うおすすめのコースを作成し、投稿することで、全員で共有ができるようになります。
「ずっと同じコースで飽きてきた」、「他の人はどんなコースを走っているんだろう」と思っている人はいませんか？このアプリを使えば、簡単におすすめのコースが見つかります！

## 本番環境URL
- 現在作成中
ログイン情報（テスト用）
- メールアドレス → test@example.com
- パスワード → testtest1

## 制作背景（意図）
ランニングやウォーキングをする上で、簡単に共有ができるようにしたいという思いからアプリ制作を始めました。近年ランニングアプリも素晴らしい機能を備えたものが多くあります。しかし、距離測定や目標管理等の機能が充実している分、気軽に無料で使用できるアプリが少ないのが現状です。特に他人と簡単に繋がることができ、コースの共有等ができるアプリがなかったため、このアプリを作成しようと思いました。「ずっと同じコースで飽きてきた」、「他の人はどんなコースを走っているんだろう」と思っている人のために、気軽に共有ができるアプリを目指しています。

## DEMO
- 現在作成中

## 工夫した点
- 作成途中
- 交通量等のアンケート機能において、新規投稿時は1つしか選択できないようにラジオボタンで実装し、投稿検索時は複数の選択肢が選べるようにチェックボックスで実装した点。

## 使用技術（開発環境）
### バックエンド
- Ruby、Ruby on Rails

### フロントエンド
- HTML、CSS、JavaScript、jQuery、Ajax

### データベース
- MySQL

### インフラ
- 現在作成中

### ソース管理
- GitHub、GitHubDesktop

### テスト
- RSpec

### エディタ
- VSCode

## 実装予定の内容
- APIを用いたマップルート作成機能
- コメント機能（非同期）
- ユーザーフォロー機能

## DB設計
### usersテーブル
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

#### Association
- has_many :posts
- has_many :comments
- has_many :likes

### postsテーブル
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

#### Association
- belongs_to :user
- has_many :comments
- has_many :likes

### commentsテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :post

### likesテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :post