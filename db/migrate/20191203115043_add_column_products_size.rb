class AddColumnProductsSize < ActiveRecord::Migration[5.0]
  def change
    add_column :products_sizes, :size, :integer
  end
end
