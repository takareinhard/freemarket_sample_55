class ProductsController < ApplicationController
  
  def index
    @products = Product.includes(:category).order(id: "DESC").limit(10)
  end

  def new
  end
  
  def create
  end

  def show
    @product = Product.find(params[:id])
    @user = @product.user
    @goods = Rate.where(rate: 1, user_id: @user.id)
    @normals = Rate.where(rate: 2, user_id: @user.id)
    @bads = Rate.where(rate: 3, user_id: @user.id)
    @products = ProductImage.where(product_id: params[:id])
  end

  def search
  end

  def update
  end

  def destroy
    product = Product.find(params[:id])
    if product.user_id == current_user.id
      product.destroy
      redirect_to root_path, notice: "商品の削除が完了しました"
    end
  end

  def get_delivery
  end

  def product_purchase_confirmation
    @product = Product.find(params[:id])
    @user = current_user.profile
  end
  
  require 'payjp'

  def purchase
    @product = Product.find(params[:id])
    Payjp.api_key = 'sk_test_88a4b35f1038b2298666f28f'
    Payjp::Charge.create(currency: 'jpy', amount: @product.price, customer: current_user.credit_card.customer_id)
    redirect_to root_path, notice: "支払いが完了しました"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :detail, :condition, :postage_payer, :shipping_area, :shipping_days, :deal, :category_id, user_id).merge(user_id:current_user.id)
  end

end
