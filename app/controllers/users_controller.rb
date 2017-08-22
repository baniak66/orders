class UsersController < ApplicationController
  def status
    if current_user
      render json: current_user
    else
      render json: { "error": "no user" }, status: 404
    end
  end
end
