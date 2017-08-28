class OrdersController < ApplicationController

  before_action :authenticate, only: [:create, :destroy]
  before_action :set_order, only: [:destroy, :update]
  before_action :check_order_author, only: :destroy
  before_action :check_meals_presence, only: :destroy
  before_action :check_meals_absence, only: :update

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
    if @order.delete
      render :json => @order
    end
  end

  def update
    if @order.update(order_params)
      render :json => @order
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant, :status)
  end

  def check_meals_presence
    if @order.meals.exists?
      render json: { "error": "You can't delete order with meals" }, status: 403
    end
  end

  def check_order_author
    unless @order.user_id == current_user.id
      render json: { "error": "This is not your order" }, status: 401
    end
  end

  def check_meals_absence
    if @order.meals.empty?
      render json: { "error": "You can't chenge status of empty order" }, status: 403
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
