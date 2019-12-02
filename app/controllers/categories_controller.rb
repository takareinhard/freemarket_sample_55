class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("ancestry ASC, id ASC").limit(13)
  end
  
  def member_information_input
    
  end
  
  def sms_authentication
  end

  def profile
  end

  def payment
  end

  def member_finish
  end

  def new_member_registration
  end

  def old_member_registration
  end

  def mypage
  endΩ
  
  def edit_profilepロフィェ
  end

  def logout
  end
  
  def product_exhibit
  end
end
