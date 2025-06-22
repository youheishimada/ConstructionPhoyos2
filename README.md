# 建設写真支援アプリ

### 手軽に工事写真の合成機能で「業務の効率化」と「現場の負担の軽減」を実現

このアプリは、工事写真のアップロード・黒板合成・編集・ダウンロードまで一括管理できる、建設現場向けの写真台帳作成支援ツールです。
現場担当者の「写真整理の手間」や「黒板合成の煩雑さ」を大幅に削減し、業務の効率化と現場負担の軽減を実現します。

主な機能

📷 写真アップロード
   工事現場で撮影した写真を簡単にアップロード＆保存

🖋️ 黒板文字の合成
   入力フォームから現場情報を入力すると、黒板テンプレ画像に自動でテキストを合成。現場ごとの記録写真を簡単に作成
   
🖼️ 合成画像のダウンロード
  合成済みの黒板付き写真はワンクリックでダウンロード可能。
  提出書類や台帳作成の業務も効率UP

🗂️ プロジェクト・日付ごとに写真を整理
プロジェクト単位＆日付別で写真が自動グループ化。
大量の画像もすぐに探せる

📝 編集・削除・履歴管理
写真や黒板内容の編集、削除、変更履歴（ログ）も保存

📱 スマートフォン対応UI
現場ですぐ使えるシンプルなデザイン。PC/スマホ両対応

🏗️ アプリのイメージ

プロジェクト新規作成 → 写真アップロード → 黒板内容入力 → 合成画像自動生成・ダウンロード


🎯 このアプリで解決できること##

工事写真台帳作成にかかる手作業・Excel操作の負担を削減

写真のバラバラ管理や記録漏れを防止

台帳の整理・提出がスムーズに

写真付き日記帳・観察記録ツールとしても応用可能

###🛠️ 制作背景
 建設現場の写真台帳作成は、手作業やパソコンによるExcel作業が中心で、多くの時間と手間がかかっていました。
このアプリは、**「誰でも・どこでも・簡単に」**現場写真の管理と台帳作成ができるよう、現場記録業務の負担軽減を目的に開発されました。

🌐 アプリURL
 🔗 https://constructionphoyos2-1.onrender.com
 Basic認証 ID：admin
 Basic認証 パスワード：17web


🧱 使用技術・ライブラリ

・言語: Ruby 3.2.0 / JavaScript

・フレームワーク: Ruby on Rails 7.1

・DB: MySQL（開発）/ PostgreSQL（本番）

・ファイル管理: ActiveStorage

・UI: Bootstrap5/CSS

・認証: Devise

・画像合成: MiniMagick

・デプロイ: Render

モデル例
・User（ユーザー管理・認証）

・Project（プロジェクト単位で管理）

・Photo（工事写真＋黒板合成情報＋画像）

・ActionLog（編集履歴）

🚀 今後のアップデート予定
📱 スマートフォン向けUI最適化

📝 黒板内容テンプレート機能

📊 ExcelやPDFへの台帳出力

🔐 さらなるセキュリティ強化

制作者
shimada（個人開発／ポートフォリオ用途）

## 🧭 画面遷移図

本アプリケーションの主要な画面の遷移構成を以下に示します。

![画面遷移図](https://gyazo.com/7cc657e81ca4f6e584c4bcdbbdfdf26c/raw)

- ユーザーはログイン後、プロジェクト一覧から各現場の写真管理が可能です。
- プロジェクトごとに写真をアップロードし、黒板情報を入力することで合成処理が行われます。
- 合成済みの写真は編集・削除・ダウンロードが可能です。
- 編集履歴はActionLogとして記録され、将来的に閲覧可能な機能も追加予定です。

データベース設計（ER図）

以下は本アプリケーションのER図です。

![ER図](https://gyazo.com/8488fa9eb08a09639360788814f2918c/raw)


ユーザーは複数のプロジェクトを持つ

プロジェクトは複数の写真を持つ

写真には黒板情報・編集履歴が紐づく

ActiveStorageで画像ファイルを管理


📋 データベース設計（テーブル一覧）

■ Users テーブル

管理者・現場担当者の情報を管理するテーブル

| カラム名     | 型     | 制約        |
|-----------|--------|-------------|
| title     | string | null: false |
| site_name | string | null: false |
| name      | string | null: false |
・has_many :projects

■Projects テーブル

・工事単位でのグルーピング用テーブル
| カラム名     | 型     | 制約        |
|-----------|--------|-------------|
| title     | string | null: false |
| site_name | string | null: false |
| site_date | date   |             |
| end_date  | date   |             |

・belongs_to :user
・has_many :photos

■Photos テーブル
・工事写真、黒板情報、合成情報を保持するテーブル
| カラム名            | 型         | 制約              |
|------------------|------------|-------------------|
| category         | string     | null: false       |
| contractor       | string     |                   |
| date             | date       | null: false       |
| location         | string     |                   |
| work_content     | string     |                   |
| work_number      | string     |                   |
| project_name     | string     |                   |
| taken_name       | string     |                   |
| note             | text       |                   |
| deleted          | boolean    | default: false    |
| overlay_text_1～5 | string     |                   |
| project_id       | references | foreign_key: true |

・belongs_to :project
・has_one_attached :image
・has_one_attached :image_with_blackboard
・has_many :action_logs

ActionLogs テーブル

写真の編集・削除の履歴を保存するテーブル

| カラム名       | 型         | 制約                                              |
|-------------|------------|---------------------------------------------------|
| action_type | string     | null: false                                       |
| detail      | text       |                                                   |
| photo_id    | references | foreign_key: true, null: true, on_delete: nullify |

🛠️ ローカルでの動作手順
$ git clone https://github.com/youheishimada/ConstructionPhoyos2.git
$ cd construction-photos
$ bundle install
$ rails db:create && rails db:migrate
$ rails s

⏰ 制作時間

約80時間（設計〜実装〜テスト〜デプロイ）

👤 開発者

shimada（個人開発 / ポートフォリオ提出用）

6月23日　機能追加：工事写真台帳アプリへのExcel出力機能の実装

■ 概要
Railsで開発した工事写真台帳アプリにおいて、写真情報をExcelファイル（.xlsx形式）として出力できる機能を新たに実装。ユーザーが撮影・登録した工事写真に紐づく各種情報（工事番号・場所・内容・撮影日・担当者・メモなど）を、ワンクリックで帳票形式のExcelにまとめてダウンロード可能とした。

■ 実装内容
axlsx_rails を活用し、Excelテンプレート（index.xlsx.axlsx）を作成

photos#index アクションに .xlsx フォーマット対応を追加し、Excel生成用のデータをコントローラで準備

ダウンロード時に自動でファイル名に日付とプロジェクトIDが入るように設定

各行に工事写真の基本情報（ID、工事番号、場所、内容、撮影日、担当者、メモ）を1レコードずつ出力

ExcelファイルはボタンやURLアクセスにより即時生成・ダウンロード可能

■ 技術要素
Ruby on Rails 7

axlsx / axlsx_rails

RESTfulルーティングとフォーマット分岐による出力制御（HTML / XLSX）

セキュリティを考慮した認証付きダウンロード制御（Devise）

■ 効果
工事の進捗や履歴を関係者へExcel形式で共有可能になり、現場帳票としての運用性が向上

Excelのフォーマットを柔軟にカスタマイズ可能とし、今後の帳票要件追加にも容易に対応可能

