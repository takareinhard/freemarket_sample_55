class ProductsController < ApplicationController
  
  def index
    # @product = Products.all
  end

  def new
  end
  
  def create
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
  end

  def update
  end

  def destroy
  end

  def get_delivery
  end

  def product_purchase_confirmation
    @product = Product.find(params[:id])
  end
  
  require 'payjp'

  def purchase
    @product = Product.find(params[:id])
    Payjp.api_key = 'sk_test_88a4b35f1038b2298666f28f'
    Payjp::Charge.create(currency: 'jpy', amount: @product.price, customer: current_user.credit_card.customer_id)
    redirect_to root_path, notice: "支払いが完了しました"
  end

end
