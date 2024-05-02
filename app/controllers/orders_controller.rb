class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:show, :edit, :update]

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save!
    redirect_to @order, notice: 'Pedido registrado com suceso.'
  end

  def show ; end

  def index
    @orders = current_user.orders
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)

    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso!'
  end

  private
  def check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, notice: "Você não tem permissão para acessar essa página!"
    end
  end
end
