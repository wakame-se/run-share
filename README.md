README
# アプリケーション名
RunShare

# 概要
本アプリは、ランニングやウォーキングのコースを共有できるアプリケーションです。利用者が思うおすすめのコースを作成し、投稿することで、全員で共有ができるようになります。
「ずっと同じコースで飽きてきた」、「他の人はどんなコースを走っているんだろう」と思っている人はいませんか？このアプリを使えば、簡単におすすめのコースが見つかります！

# 本番環境URL
https://run-share.net

ログイン情報（テスト用）
- メールアドレス → test@example.com
- パスワード → testtest1

# 制作背景（意図）
ランニングやウォーキングをする上で、簡単にコース共有ができるようにしたいという思いからアプリ制作を始めました。近年ランニングアプリも素晴らしい機能を備えたものが多くあります。しかし、距離測定や目標管理等の機能が充実している分、気軽に無料で使用できるアプリが少ないのが現状です。特に他人と簡単に繋がることができ、コースの共有等ができるアプリがなかったため、このアプリを作成しようと思いました。「ずっと同じコースで飽きてきた」、「他の人はどんなコースを走っているんだろう」と思っている人のために、気軽に共有ができるアプリを目指しています。

# DEMO
トップページ
[![Image from Gyazo](https://i.gyazo.com/1170a7a61a5979d2613b9539774d3205.jpg)](https://gyazo.com/1170a7a61a5979d2613b9539774d3205)
- アプリへの入口となるページです。
- 他の人の投稿を見るだけなら「コースを探す」をクリック、自分で投稿したい・他の人の投稿にいいねやコメントをしたい人は「新規登録」か「ログイン」をクリック。

投稿一覧・検索ページ
[![Image from Gyazo](https://i.gyazo.com/10430d69dd3bafab09321e5781a861b7.gif)](https://gyazo.com/10430d69dd3bafab09321e5781a861b7)
- 全投稿が表示され、新規投稿順や人気順等で投稿の並べ替えができます。
- 画面左側には検索機能があり、住所や距離、コースの種類等で絞り込みができます。
- いいと思った投稿にはいいねができます。

新規登録/ユーザー情報編集ページ
[![Image from Gyazo](https://i.gyazo.com/7b869e137f001a794477c23d3d871f3f.png)](https://gyazo.com/7b869e137f001a794477c23d3d871f3f)
- ニックネーム、メールアドレス、パスワード、名前、生年月日を入力すると新規登録ができます。
- 登録情報の編集も新規登録と同様に、ユーザー情報編集ページでできます。

新規投稿/編集ページ
[![Image from Gyazo](https://i.gyazo.com/bdf1739e2a155ec41484e343bfe43ae3.png)](https://gyazo.com/bdf1739e2a155ec41484e343bfe43ae3)
- マップルートの作成、距離やコースの種類等を入力すると新規投稿ができます。
- 編集も新規投稿と同様に、編集ページでできます。

投稿詳細ページ
[![Image from Gyazo](https://i.gyazo.com/0139cbd0905597de8e73c45c4d93531e.png)](https://gyazo.com/0139cbd0905597de8e73c45c4d93531e)
- 投稿一覧ページより詳細な投稿内容（どんなコースか等）が見れます。
- その投稿に対してコメントができます。

# 工夫した点
- 地図には著作権の問題があり、スクリーンショット等で簡単には共有できない。そこでユーザーに共有リンクを投稿してもらうことで、地図の共有をする代替案を実装した点。
- 郵便番号を入力するだけで、住所も自動入力されるように実装した点。
- 交通量等のアンケート機能において、新規投稿時は1つしか選択できないようにラジオボタンで実装し、投稿検索時は複数の選択肢が選べるようにチェックボックスで実装した点。
- 環境構築を楽にするためにDockerを導入した点。

# 使用技術
## バックエンド
- Ruby、Ruby on Rails

## フロントエンド
- HTML、CSS、JavaScript、jQuery、Ajax

## データベース
- AWS（RDS→本番環境のみ）、MySQL、SequelPro

## インフラ
- AWS（EC2、S3）、Docker

## Webサーバ
- Nginx

## アプリケーションサーバ
- puma

## ソース管理
- GitHub、GitHubDesktop

## テスト
- RSpec

## エディタ
- VSCode

# 課題と今後実装したい機能
## アプリ機能
- APIを用いたマップルート作成機能
- お気に入り機能（お気に入りの投稿のみ表示させる）

## インフラ
- circleCIを用いた自動テスト・デプロイ

# DB設計
## usersテーブル
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
- has_many :likes

## postsテーブル
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
- has_many :likes
- has_one :address

## commentsテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post

## likesテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post

## addressesテーブル
| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | integer    | null: false                    |
| prefecture_code | integer    | null: false                    |
| city            | string     | null: false                    |
| street          | string     | null: false                    |
| post            | references | null: false, foreign_key: true |

### Association
- belongs_to :post