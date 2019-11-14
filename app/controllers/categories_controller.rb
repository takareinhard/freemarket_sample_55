class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("ancestry ASC, id ASC").limit(13)
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category).page(params[:page]).per(8).order("created_at DESC")
  end
  
end
