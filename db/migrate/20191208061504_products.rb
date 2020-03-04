class Products < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :product_image
  end
end
