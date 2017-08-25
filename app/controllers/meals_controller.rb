class MealsController < ApplicationController

  def create
    @order = Order.find(params[:order_id])
    @meal = @order.meals.new(meal_params)
    @meal.user_id = current_user.id
    if @meal.save
      render json: @meal
    else
      render json: { "error": @meal.errors.full_messages.join(", ") }, status: 400
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :price)
  end

end
