class UsersController < ApplicationController
  def status
    if current_user.nil?
      render json: { "error": "no user" }, status: 404
    else
      render json: current_user
    end
  end
end
