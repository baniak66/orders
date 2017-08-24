class OrdersController < ApplicationController

  def index
    @orders = Order.all
    render json: @orders, include: [:user]
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      render json: @order, include: [:user]
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant)
  end
end
