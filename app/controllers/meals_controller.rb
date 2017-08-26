class MealsController < ApplicationController

  before_action :authenticate, only: [:create]
  before_action :check_owner, only: [:destroy]

  def create
    @order = Order.find(params[:order_id])
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
end
