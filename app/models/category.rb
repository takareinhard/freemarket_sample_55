class Category < ApplicationRecord
  has_many :products
  has_ancestry
  belongs_to :parent, class_name: :Category
  has_many :children, class_name: :Category, foreign_key: :parent_id
  has_many :category_sizes
  has_many :products_sizes, through: :category_sizes
end
