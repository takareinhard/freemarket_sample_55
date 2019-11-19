class Category < ApplicationRecord
  has_many :products
  has_ancestry
  belongs_to :brand
end
