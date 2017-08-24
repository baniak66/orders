class OrdersController < ApplicationController

  before_action :authenticate, only: [:create]

  def index
    @orders = Order.all
    render json: @orders, include: [:user]
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      render json: @order, include: [:user]
    else
      render json: { "error": @order.errors.full_messages[0] }, status: 400
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant)
  end

  def authenticate
    unless current_user
      render json: { "error": "Please login..." }, status: 401
    end
  end

end
