class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("ancestry ASC, id ASC").limit(13)
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category).page(params[:page]).per(8).order("created_at DESC")
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :detail, :condition, :postage_payer, :shipping_area, :shipping_days, :deal, :category_id, user_id).merge(user_id:current_user.id)
  end
  
  def product_image_params
    params.require(:product_image).permit(:image)
  end

end
