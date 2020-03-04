class ProductImage < ApplicationRecord
  belongs_to :product,  foreign_key: :product_id,  dependent: :destroy, optional: true
  mount_uploader :image, ImageUploader
end
