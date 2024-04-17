class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @supplier = Supplier.all
    @product_model = ProductModel.new
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: "Modelo de Produto cadastrado com sucesso!"
    else
      @supplier = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto!'
      render 'new'
    end

  end

  def show
    @product_model = ProductModel.find params[:id]
  end

  private
  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end
