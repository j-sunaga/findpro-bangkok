## README

2020.5.2更新。現在は未完成です。

## 目次
[バンコクで身近なプロを見つける"_FindPro_"](#バンコクで身近なプロを見つける掲示板"_FindPro_")

[バージョン](#バージョン)

[機能一覧](#機能一覧)

[設計資料](#設計資料)

[使用予定gem](#使用予定gem)

---------------------------------------

### バンコクで身近なプロを見つける"_FindPro_"

日常の生活で困りごと(買い物代行・現地ローカルレストランの案内など)について
求人サイトで募集するほどではないけど、信頼できる人を見つけたいという人に向けたサービスです。困りごとをきっかけに現地のタイ人プロフェッショナルと知り合い,つながることができます。

---------------------------------------
### バージョン
`Ruby 2.6.5`
`Rails 5.2.4.2`

---------------------------------------
### 機能一覧
【ログイン機能】


【ユーザー登録・編集】
（名前、メールアドレス、パスワードは必須、応募者or募集者か登録）


【募集投稿】
一覧・登録・編集・削除 タイトルは必須。*募集者のみが可能。

【応募者閲覧】
一覧・詳細。全ユーザ可

【応募機能】
募集投稿への応募

【コメント】
機能募集投稿へのコメント。
*コメント編集・削除はコメントしたユーザのみ。
コメント機能はページ遷移なしで可.

【応募者決定機能】
依頼する担当者を決定する

【ユーザの評価】
作業後に双方のユーザの評価機能

【個別メッセージ】
登録ユーザは１対１の個別メッセージを交換できる

【メール通知】
以下のタイミングでメール通知が担当者に送付される。
(1)募集投稿に対して応募があった、(2)募集に対する担当者を決定、(3)個別メッセージを受信

---------------------------------------

### 設計資料

#### カタログ設計、テーブル定義、画面遷移図
https://drive.google.com/open?id=12EEUBc8B11mcNk6pMvWfXbCzWOsRVtXSlvgSjsF0COk

#### ワイヤーフレーム
https://drive.google.com/open?id=13505Rh7U1bYho7LxpJ89DCfyigJ7z4Qq

---------------------------------------

### 使用予定gem
- carrierwave
- mini_magic
- devise
- ransack
- rails_admin
- cancancan
- bootstrap 4.4.1'
- kaminari
- letter_opener_web
- bullet
- pry-rails
- better_errors
- binding_of_caller

---------------------------------------

### 使用予定技術

【就業Term】

- AWS
- devise
- コメント機能
- メッセージ機能

【カリキュラム外】

- rails_admin
- ransack

### デモ

![demo](https://user-images.githubusercontent.com/55880360/86082296-5b8bab80-bad2-11ea-9ac5-2b44b1c0684d.gif)

