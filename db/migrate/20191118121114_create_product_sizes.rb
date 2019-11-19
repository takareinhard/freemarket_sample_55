class CreateProductSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :product_sizes do |t|
      t.integer :size, null: false
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
