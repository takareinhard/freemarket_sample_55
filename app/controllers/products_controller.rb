class ProductsController < ApplicationController
  
  def index
    # @product = Products.all
  end

  def new
    @product = Product.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end
     # 親カテゴリーが選択された後に動くアクション
  def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
      # binding.pry
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
  
  require 'payjp'

  def show
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
