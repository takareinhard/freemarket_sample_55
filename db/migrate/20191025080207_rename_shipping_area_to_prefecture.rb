class RenameShippingAreaToPrefecture < ActiveRecord::Migration[5.0]
  def change
    create_table :Prefecture do |t|
      t.string :prefecture
      t.timestamps
    end
  end
end
