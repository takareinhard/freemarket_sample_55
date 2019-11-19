class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :rate
      t.references :user, null: false, foreign_key: true
      t.text :comment
      t.timestamps
    end
  end
end
