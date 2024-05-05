# README

## 使用技術

+ フロントエンド : Hotwire, Stimulus
+ バックエンド : Ruby3.2/Rails7.0.8
+ データ管理 : PostgreSQL (14系)
+ インフラ : Docker
+ 画像投稿 : ActiveStorage, Amazon S3
+ 静的コード解析 : RuboCop
+ 本番デプロイ環境 : Render


## 機能一覧

+ サインアップ・ログイン (deviseを導入)
+ githubログイン認証
+ ページネーション
+ ツイート投稿
+ 画像投稿
+ コメント投稿
+ プロフィール編集
+ いいね
+ リツイート
+ フォロー
+ ブックマーク
+ メッセージ
+ 通知 



## 前提

- dockerが必要です。

## setup

```
docker compose build
```

```
docker compose run --rm web bin/setup
```


```
docker compose run --rm web yarn install
```

## run

```
docker compose up
```

http://localhost:3000

## 備考


## rubocop

rubocopがすべて通ってからレビュー依頼を出してください。

auto correct

```
docker compose run --rm web bundle exec rubocop -A
```

## htmlbeautifier

erbのフォーマッターです。
フォーマッターを通してからレビュー依頼を出してください。

```
docker compose run --rm web bin/htmlbeautifier
```
