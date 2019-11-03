class Products < ActiveRecord::Migration[5.0]
  def up
    add_column :products, :image, :string, :null => false
  end
end
