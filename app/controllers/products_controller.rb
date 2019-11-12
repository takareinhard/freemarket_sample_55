class ProductsController < ApplicationController
  
  def index
    # @product = Products.all
  end

  def new
    @product = Product.new
  end
  
  def create
  end

  require 'payjp'

  def show
  end

  def search
  end

  def update
  end

  def destroy
  end

  def get_delivery
  end

  require 'payjp'

  def product_purchase_confirmation
    Payjp.api_key = "sk_test_88a4b35f1038b2298666f28f"
    Payjp::Charge.create(
      amount: 809, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

  def self.create_charge_by_customer(customer, amount)
    Payjp::Charge.create(
      amount:   amount,
      customer: customer,
      currency: 'jpy'
    )
  end

end
