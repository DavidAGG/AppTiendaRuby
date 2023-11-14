class CategoriesController < ApplicationController
    before_action :authorize!
    before_action :set_category, only: %i[ show edit update destroy ]
  
    def index
      authorize! #Para verificar si Current.user es admin
      @categories = Category.all.order(name: :asc) #El .all.order es para ordenar por orden alfabetico
    end
  
    def new
      @category = Category.new
    end
  
    def edit
      @category
    end
  
    def create
      @category = Category.new(category_params)
  
      respond_to do |format|
        #SI SE PONE 'format.pdf' te crea un PDF, si es format.csv da un CSV y así
        if @category.save
          format.html { redirect_to categories_url, notice: "Category was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to categories_url, notice: "Category was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  

    def destroy
      @category.destroy
  
      respond_to do |format|
        format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def category_params
        params.require(:category).permit(:name)
      end
  end