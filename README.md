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

📘 工事写真台帳アプリ：6月26日  Excel出力機能 の調整と実証試験、問題点の検証
✅ 1. Excel出力機能（axlsx_rails）の実装
photos#index アクションに .xlsx 対応を追加

axlsx_rails を用いて、index.xlsx.axlsx テンプレートを新規作成

出力対象の内容として、以下の情報を含める仕様に決定：

黒板付き画像ファイル名（例: combined_23.jpg）

年月日（例: 2024/11/10）

工事番号（例: AB-123）

工事個所（例: A区1丁目）

工事内容（例: アスファルト舗装打設）

データは「縦方向4項目＋1枚画像名」の構成で出力、蔵衛門など他ソフトへのコピペを前提に整形

実際に .xlsx を生成し、curl でダウンロード → Excelで開く検証にも成功

✅ 2. .xlsm テンプレートを元にした出力検証（実験段階）
ユーザー提供の .xlsm 台帳見本ファイル（写真＋説明が隣接配置された形式）を参考に、自動反映の検討

実装候補としては以下が挙げられた：

VBA（Excelマクロ）でRails生成ファイルを取り込み・差し込み

Python（openpyxl, xlwings）などによる .xlsm 操作

結論として、現時点では .xlsm 出力の自動化は保留
　→ 将来的な課題とし、今は .xlsx に必要情報を整形して出力する形を採用

✅ 3. 今後の方針
項目	内容
🎯 目的	黒板付き画像と対応情報の整形されたExcel出力（コピペ・印刷用）
🔧 技術	axlsx_rails を活用した .xlsx 自動出力
✍️ 改善案	- レイアウト微調整（1行出力 or セル結合など）
- 項目の並び替えや翻訳も可能に
🔜 将来	- VBA / Python による .xlsm テンプレ反映の自動化
- 画像の直接貼り付けによる視認性向上
6月23日　機能追加：工事写真台帳アプリへのExcel出力機能の実装

■ 概要 Railsで開発した工事写真台帳アプリにおいて、写真情報をExcelファイル（.xlsx形式）として出力できる機能を新たに実装。ユーザーが撮影・登録した工事写真に紐づく各種情報（工事番号・場所・内容・撮影日・担当者・メモなど）を、ワンクリックで帳票形式のExcelにまとめてダウンロード可能とした。

■ 実装内容 axlsx_rails を活用し、Excelテンプレート（index.xlsx.axlsx）を作成

photos#index アクションに .xlsx フォーマット対応を追加し、Excel生成用のデータをコントローラで準備

ダウンロード時に自動でファイル名に日付とプロジェクトIDが入るように設定

各行に工事写真の基本情報（ID、工事番号、場所、内容、撮影日、担当者、メモ）を1レコードずつ出力

ExcelファイルはボタンやURLアクセスにより即時生成・ダウンロード可能

■ 技術要素 Ruby on Rails 7

axlsx / axlsx_rails

RESTfulルーティングとフォーマット分岐による出力制御（HTML / XLSX）

セキュリティを考慮した認証付きダウンロード制御（Devise）

■ 効果 工事の進捗や履歴を関係者へExcel形式で共有可能になり、現場帳票としての運用性が向上

Excelのフォーマットを柔軟にカスタマイズ可能とし、今後の帳票要件追加にも容易に対応可能

📘 工事写真台帳アプリ：6月26日 Excel出力機能 の調整と実証試験、問題点の検証 ✅ 1. Excel出力機能（axlsx_rails）の実装 photos#index アクションに .xlsx 対応を追加

axlsx_rails を用いて、index.xlsx.axlsx テンプレートを新規作成

出力対象の内容として、以下の情報を含める仕様に決定：

黒板付き画像ファイル名（例: combined_23.jpg）

年月日（例: 2024/11/10）

工事番号（例: AB-123）

工事個所（例: A区1丁目）

工事内容（例: アスファルト舗装打設）

データは「縦方向4項目＋1枚画像名」の構成で出力、蔵衛門など他ソフトへのコピペを前提に整形

実際に .xlsx を生成し、curl でダウンロード → Excelで開く検証にも成功

✅ 2. .xlsm テンプレートを元にした出力検証（実験段階） ユーザー提供の .xlsm 台帳見本ファイル（写真＋説明が隣接配置された形式）を参考に、自動反映の検討

実装候補としては以下が挙げられた：

VBA（Excelマクロ）でRails生成ファイルを取り込み・差し込み

Python（openpyxl, xlwings）などによる .xlsm 操作

結論として、現時点では .xlsm 出力の自動化は保留 　→ 将来的な課題とし、今は .xlsx に必要情報を整形して出力する形を採用

✅ 3. 今後の方針 項目 内容 🎯 目的 黒板付き画像と対応情報の整形されたExcel出力（コピペ・印刷用） 🔧 技術 axlsx_rails を活用した .xlsx 自動出力 ✍️ 改善案 - レイアウト微調整（1行出力 or セル結合など）

項目の並び替えや翻訳も可能に 🔜 将来 - VBA / Python による .xlsm テンプレ反映の自動化
画像の直接貼り付けによる視認性向上

（2025年7月12日）
✅ 実装内容
1. アップロードされた元画像のダウンロード機能
photos_controller.rb に download_original アクションを追加。

rails_blob_url を使用して元画像ファイル（image）を直接ダウンロードできるように設定。

ビュー（show.html.erb）に「元画像ダウンロード」ボタンを追加。

2. 黒板付き画像のダウンロード機能
download_with_blackboard アクションを追加し、image_with_blackboard が添付されている場合にダウンロードを可能に。

ビューにも「黒板付き画像ダウンロード」ボタンを追加。

3. ルーティングの整備
routes.rb に以下のメンバーアクションを追加し、各写真単位でのダウンロードリンクに対応：

ruby
コピーする
編集する
member do
  get :download_original
  get :download_with_blackboard
end
4. 動作確認
Railsログ（development.log）で保存・添付処理が正しく行われていることを確認。

IRB で photo.image.attached? の検証により、元画像の状態をチェック。

rails_blob_url によりダウンロード用URLが正常に生成されることも確認済み。

✅ Git 操作履歴
変更内容をローカルで commit：

sql
コピーする
編集する
git commit -m "元画像と黒板付き画像のダウンロード機能を追加"
GitHub リモートリポジトリ ConstructionPhoyos2 に正常に push 完了：

css
コピーする
編集する
git push origin main
📝 今後の検討課題
ダウンロードボタンの表示位置・UIの調整（スマートフォン向けのレイアウトも考慮）

黒板付き画像が未生成時のリマインド通知（必要に応じて）

サブモジュール（ConstructionPhotos）の内容変更がある場合の整理

将来的にはZIPで一括ダウンロード機能やS3経由の直接リンク配布も検討

