class ProductSize < ApplicationRecord
  belongs_to :product,  foreign_key: :product_id,  dependent: :destroy
end
