class Product < ApplicationRecord
  has_many :likes
  has_one :product_image,  foreign_key: :product_id,  dependent: :destroy
  accepts_nested_attributes_for :product_image
  has_one :sell_values
  has_one :buy_values
  has_one :product_option_size
  has_one :product_option_brand
  has_one :dealing
  has_one :product_size,  foreign_key: :product_id,  dependent: :destroy
  belongs_to :user
  belongs_to :profile, optional: true
  belongs_to :category
  belongs_to :prefecture
  belongs_to :brand

  def display_size
    list = ["XXS以下","XS(SS)","S","M","L","XL","2XL(3L)","3XL(4L)","4XL(5L)以上","FREE SIZE"]
    return list[self.product_size.size]
  end

  def display_condition
    list = ["新品、未使用","未使用に近い","目立った傷や汚れなし","やや傷や汚れあり","傷や汚れあり","全体的に状態が悪い"]
    return list[self.condition]
  end

  def display_postage_payer
    list = ["送料込み（出品者負担）","着払い（購入者負担）"]
    return list[self.postage_payer]
  end

  def display_shipping_days
    list = ["1-2日で発送","2-3日で発送","4-7日で発送"]
    return list[self.shipping_days]
  end

  # def display_shipping_method
  #   list = ["未定","らくらくメルカリ便","ゆうメール","レターパック","普通郵便（定形・定形外）","クロネコヤマト","ゆうパック","クリックポスト","ゆうパケット"]
  #   return list[self.shipping_method]
  # end
  
  def self.get_items_category(category_id,products,limit)  ### category_idを渡すとそれに属している商品を配列で返す
    new_items = []
    count = 0
    category = Category.find(category_id);
    new_items = products.where(category_id: category.leaves.ids).limit(limit)
    return new_items
  end

end