#AQUI SE DEFINEN LAS ACCIONES Y SE REFERENCIAN EN routes.rb
class ProductsController < ApplicationController 
    skip_before_action :protect_pages, only: [:index, :show]

    def index 
        #El '.load_async' es para que cada elemento se imprima sin esperar que el elemento anterior se cargue primero
        @categories = Category.order(name: :asc).load_async
        @products = Product.all.load_async #ESTE ES UN SELECT * FROM (modelo) Product

        if params[:category_id]
            @products = @products.where(category_id: params[:category_id])
        end

        if params[:min_price].present? 
            @products = @products.where('price >= ?', params[:min_price])
        end

        if params[:max_price].present? 
            @products = @products.where('price <= ?', params[:max_price])
        end

        if params[:query_text].present?  #Se usa la gema 'search_full_text'
            @products = @products.search_full_text(params[:query_text])
        end

        if params[:favorites].present? 
            @products = @products.joins(:favorites).where({favorites: {user_id: Current.user.id}})
        end
       
        order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])

        @products = @products.order(order_by).load_async
        @pagy, @products = pagy_countless(@products, items: 12)


       # @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async)
    end

    def show
        product 
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'Tu producto se ha creado correctamente'
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit
        authorize! product
    end

    def update 
        authorize! product
        if product.update(product_params)
            redirect_to products_path, notice: 'Tu producto se ha actualizado'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize! product
        product.destroy

        redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente', status: :see_other
    end 
       
    private 
    def product_params #NOS PERMITE SOLO GUARDAR ESOS PARAMETROS POR SEGURIDAD
        params.require(:product).permit(:title, :description, :price, :photo, :category_id)
    end

    def product_params_index 
        params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites)
    end

#Con este método quitamos los '@' de las variables de los otros metodos porque hacen referencia a este metodo
#y este método es el que usa la variable '@product'
    def product 
        @product = Product.find(params[:id])
    end

    def categories
        @categories = Category.find(params[:id])
    end

end 