class Category < ApplicationRecord
  has_many :products, foreign_key: :product_id, dependent: :destroy
  has_ancestry
  belongs_to :brand
end
