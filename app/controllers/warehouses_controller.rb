class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @new_warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
    @new_warehouse = Warehouse.new(warehouse_params)
    if @new_warehouse.save()
      redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
    else
      flash.now[:notice] = "Galpão não cadastrado!"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def update
    id = params[:id]
    @warehouse = Warehouse.find(id)
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(id), notice: "Galpão atualizado com sucesso!"
    else
      flash.now[:notice] = "Não foi possível atualizar o galpão!"
      render 'edit'
    end
  end
end
