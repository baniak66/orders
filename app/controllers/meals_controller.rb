class MealsController < ApplicationController

  before_action :authenticate, only: [:create]

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
    @meal = Meal.find(params[:id])
    if @meal.delete
      render :json => @meal
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :price)
  end

end
