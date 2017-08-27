class MealsController < ApplicationController

  before_action :authenticate, only: [:create, :destroy]
  before_action :check_owner, only: :destroy
  before_action :check_meals, only: :create

  def create
    @meal = @order.meals.new(meal_params)
    @meal.user_id = current_user.id
    if @meal.save
      render json: @meal, include: [:user]
    else
      render json: { "error": @meal.errors.full_messages.join(", ") }, status: 400
    end
  end

  def destroy
    if @meal.delete
      render :json => @meal
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :price)
  end

  def check_owner
    @meal = Meal.find(params[:id])
    unless @meal.user_id == current_user.id
      render json: { "error": "This is not your meal" }, status: 401
    end
  end

  def check_meals
    @order = Order.find(params[:order_id])
    if @order.meals.exists?(user_id: current_user.id)
      render json: { "error": "You can add only one meal" }, status: 403
    end
  end
end
