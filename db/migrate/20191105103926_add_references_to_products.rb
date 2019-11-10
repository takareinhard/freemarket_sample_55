class AddReferencesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :prefecture, null: false, foreign_key: true
  end
end
