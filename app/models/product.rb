class Product < ApplicationRecord
  has_many :likes
  has_many :product_images
  has_one :sell_values
  has_one :buy_values
  has_one :product_option_size
  has_one :product_option_brand
  has_one :dealing
  belongs_to :user
  belongs_to :category
end
