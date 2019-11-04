class ChangeColumnToCreditCard < ActiveRecord::Migration[5.0]
  def change
    change_column :credit_cards, :card_id, :string, default: "0"
  end
end
