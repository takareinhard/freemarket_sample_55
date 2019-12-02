class ProductImage < ApplicationRecord
  belongs_to :product,  foreign_key: :product_id,  dependent: :destroy, optional: true
end
