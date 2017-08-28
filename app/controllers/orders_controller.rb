class OrdersController < ApplicationController

  before_action :authenticate, only: [:create, :destroy]
  before_action :check_order_author, only: :destroy
  before_action :check_meals_presence, only: :destroy

  def index
    @orders = Order.all
    render json: @orders.to_json(:include => [ :user, { :meals => {:include => :user}}])
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      render json: @order, include: [:user, :meals]
    else
      render json: { "error": @order.errors.full_messages[0] }, status: 400
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.delete
      render :json => @order
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      render :json => @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant, :status)
  end

  def check_meals_presence
    @order = Order.find(params[:id])
    if @order.meals.exists?
      render json: { "error": "You can't delete order with meals" }, status: 403
    end
  end

  def check_order_author
    @order = Order.find(params[:id])
    unless @order.user_id == current_user.id
      render json: { "error": "This is not your order" }, status: 401
    end
  end

end
