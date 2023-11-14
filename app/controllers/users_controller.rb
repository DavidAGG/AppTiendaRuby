class UsersController < ApplicationController
    skip_before_action :protect_pages, only: :show
    #def show
        #@user = User.find_by!(username: params[:username])
        #@pagy, @products = pagy_countless(FindProducts.new.call({user_id: @user.id}).load_async, items: 12)
    #end




    def show
        @user = User.find_by!(username: params[:username])
        @products = Product.all.with_attached_photo

        @products = @products.where(user_id: @user.id)

        order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
        @products = @products.order(order_by).load_async 
        @pagy, @products = pagy_countless(@products, items: 12)    
    end

end