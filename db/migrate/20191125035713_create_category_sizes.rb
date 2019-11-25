class CreateCategorySizes < ActiveRecord::Migration[5.0]
  def change
    create_table :category_sizes do |t|
      t.references :category
      t.references :products_size
      t.timestamps 
    end
  end
end
