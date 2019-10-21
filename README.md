### userモデル
|Column|Type|Options|
|:------|:----|:-------|
|email|string|null: false,unique: true, default: ""|
|encrypted_password|string|null: false, default: ""|
|earnings|integer|default: 0|
|points|integer|default: 0|
|card_token|string||

### Association
- has_many :administrators_message   [](運営からのメッセージ)
- has_many :notifications   [](お知らせ)
- has_many :todos   [](やることリスト)
- has_many :sell_values   [](出品者としての評価)
- has_many :buy_values   [](購入者としての評価)
- has_many :comment_products
- has_many :dealings   [](取引)
- has_many :dealing_chat_messages   [](取引チャットでの発言)
- has_many :likes   [](いいね)
- has_many :products
- has_many :buyer_dealings, class_name: 'Dealing', foreign_key: 'buyer_id'
- has_many :seller_dealings, class_name: 'Dealing', foreign_key: 'seller_id'
- has_many :buyer_sell_values, class_name: 'BuyValue', foreign_key: 'buyer_id'
- has_many :seller_sell_values, class_name: 'SellValue', foreign_key: 'seller_id'
- has_one :sms_authentication
- has_one :credit_card
- belong_to :profile

### profileモデル 
|Column|Type|Options|
|:------|:----|:-------|
|nickname|string|null: false|
|first_name|string|null: false,limit: 50|
|last_name|string|null: false,limit: 50|
|first_name_kana|string|null: false,limit: 50|
|last_name_kana|string|null: false,limit: 50|
|post_number|integer||
|prefecture|integer||
|city|string||
|house_number|string||
|building_name|string||
|birthday|date|null: false|
|tel_number|integer||
|profile|text||
|avatar|string||
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

### sms_authenticationモデル 
|Column|Type|Options|
|:------|:----|:-------|
|phone_number|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

### credit_cardモデル
|Column|Type|Options|
|:------|:----|:-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

### productモデル
|Column|Type|Options|
|:------|:----|:-------|
|name|string|null: false, index: true|
|price|integer|null: false|
|detail|text|null: false|
|condition|integer|null: false|
|postage_payer|integer|null: false|   [](送料負担者)
|shipping_area|integer|null: false|   [](発送元地域)
|shipping_days|integer|null: false|   [](発送までの日数)
|deal|integer|default: 0|   [](取引状態)
|category|references|null: false, forign_key: true|
|user|references|null: false, foreign_key: true|   [](出品者)

### Associations
- has_many :likes
- has_many :product_images
- has_one :sell_values
- has_one :buy_values
- has_one :product_option_size
- has_one :product_option_brand
- has_one :dealing
- belongs_to :user
- belongs_to :category

[](商品についてのコメントテーブル)
### comment_productsモデル 
|Column|Type|Options|
|:------|:----|:-------|
|comment|text|null: false|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- has_many :products
- belongs_to :user

[](いいねテーブル)
### likeモデル 
|Column|Type|Options|
|:------|:----|:-------|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :user

### product_imagesモデル 
|Column|Type|Options|
|:------|:----|:-------|
|image|string|null: false|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to :product

[](運営からのメッセージテーブル)
### administrator_messagesモデル
|Column|Type|Options|
|:------|:----|:-------|
|title|string|null: false|
|message|text|null: false|
|type|integer|default: 0| [](newsやキャンペーン,個別メッセージなど)
|url|string|| [](newsなどの個別のURLを入れる)
|user|references|default: 0, foreign_key: true|   [](個別メッセージの宛先,0以下なら全員)

### Association
- has_one :user

[](お知らせテーブル)
### notificationsモデル
|Column|Type|Options|
|:------|:----|:-------|
|title|string|null: false|
|message|text|null: false|
|user|references|default: 0, foreign_key: true|

### Association
- belongs_to :user

### brandsモデル
|Column|Type|Options|
|:------|:----|:-------|
|name|string|null: false|

### Association
- has_many :products
- has_many :categories

[](各商品のサイズについてのテーブル)
### product_sizeモデル 
|Column|Type|Options|
|:------|:----|:-------|
|size|integer|null: false|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to :product

### categoriesモデル 
|Column|Type|Options|
|:------|:----|:-------|
|name|string|null: false, index: true|
|ancestry|string|| [](親子関係)

### Association
- has_many :products
- has_one :category_option　[](カテゴリーにブランドやサイズの指定があるかどうか)

### category_optionsモデル 
|Column|Type|Options|
|:------|:----|:-------|
|brand|integer|default:0|
|size|integer|default:0|
|category|references|null: false, foreign_key: true|

### Association
- belongs_to :category

[](取引テーブル)
### dealingsモデル 
|Column|Type|Options|
|:------|:----|:-------|
|phase|integer|default:0|
|seller_datetime|datetime|null: false|   [](直近のチャット閲覧日時)
|buyer_datetime|datetime|null: false|   [](直近のチャット閲覧日時)
|product|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- has_many :dealing_chat_messages
- has_many :todos

[](取引チャットのメッセージを入れておくテーブル)
### dealing_chat_messagesモデル 
|Column|Type|Options|
|:------|:----|:-------|
|messages|text|null: false|
|dealing|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :dealing
- belongs_to :user

[](出品者としての評価テーブル)
### sell_valuesモデル 
|Column|Type|Options|
|:------|:----|:-------|
|rate|integer|null: false|
|comment|text|null: false|
|product|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :buyer, class_name: 'User', :foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id

[](購入者としての評価テーブル)
### buy_valuesモデル 
|Column|Type|Options|
|:------|:----|:-------|
|rate|integer|null: false|
|comment|text|null: false|
|product|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|

### Association
- belongs_to :product
- belongs_to :buyer, class_name: 'User', :foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id

[](やることリストテーブル)
### todosモデル
|Column|Type|Options|
|:------|:----|:-------|
|message|text|null: false|
|dealing|references|foreign_key: true|
|user|references|foreign_key: true|

### Association
- belongs_to :dealing
- belongs_to :user
