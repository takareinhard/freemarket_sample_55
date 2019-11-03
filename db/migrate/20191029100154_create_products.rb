class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

      t.string :name, null:false, index: true
      t.integer :price, null:false
      t.text :detail, null:false
      t.integer :condition, null:false
      t.integer :postage_payer, null:false #送料負担者
      t.integer :shipping_area, null:false #発送元地域
      t.integer :shipping_days, null:false #発送までの日数
      t.integer :deal, default: 0 #取引状態
      t.references :category, null:false, forign_key: true
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end
