class RemovePrefectureFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :prefecture, :string
  end
end
