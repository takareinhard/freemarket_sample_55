class ProductsController < ApplicationController
  
  def index
    @products = Product.includes(:category).order(id: "DESC").limit(10)
  end

  def new
    @product = Product.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @products = Product.includes(:category).order(id: "DESC").limit(10)
  end

  def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

   # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
     @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_size
    selected_grandchild = Category.find("#{params[:grandchild_id]}") #孫カテゴリーを取得
    if related_size_parent = selected_grandchild.products_sizes[0] #孫カテゴリーと紐付くサイズ（親）があれば取得
       @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
    else
       selected_child = Category.find("#{params[:grandchild_id]}").parent #孫カテゴリーの親を取得
       if related_size_parent = selected_child.products_sizes[0] #孫カテゴリーの親と紐付くサイズ（親）があれば取得
          @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
       end
    end
  end

  
  
  def show
    @product = Product.find(params[:id])
    @user = @product.user
    @goods = Rate.where(rate: 1, user_id: @user.id)
    @normals = Rate.where(rate: 2, user_id: @user.id)
    @bads = Rate.where(rate: 3, user_id: @user.id)
    @products = ProductImage.where(product_id: params[:id])
  end
  
  require 'payjp'

  def show
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
