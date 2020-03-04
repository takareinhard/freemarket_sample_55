class AddCardTokenToCreditCards < ActiveRecord::Migration[5.0]
  def change
    add_column :credit_cards, :card_token, :string
  end
end
