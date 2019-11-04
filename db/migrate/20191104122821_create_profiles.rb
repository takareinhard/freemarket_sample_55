class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :nickname, null: false
      t.string :first_name, null: false,limit: 50
      t.string :last_name, null: false,limit: 50
      t.string :first_name_kana, null: false,limit: 50
      t.string :last_name_kana, null: false,limit: 50
      t.integer :post_number
      t.integer :prefecture
      t.string :city
      t.string :house_number
      t.string :building_name
      t.date :birthday, null: false
      t.integer :tel_number
      t.text :profile
      t.string :avator
      t.references :user, null: false,foreign_key: true
      t.timestamps
    end
  end
end
