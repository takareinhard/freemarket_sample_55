class ProductsController < ApplicationController
  
  def index
    # @product = Products.all
  end

  def new
    @product = Product.new
    # binding.pry
  end
  
  def create
  end

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

  def purchase
    Payjp.api_key = 'sk_test_88a4b35f1038b2298666f28f'
    Payjp::Charge.create(currency: 'jpy', amount: 1000, customer: current_user.credit_card.customer_id)
    redirect_to root_path, notice: "支払いが完了しました"
  end

end
