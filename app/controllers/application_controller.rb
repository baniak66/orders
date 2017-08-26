class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    unless current_user
      render json: { "error": "Please login..." }, status: 401
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user
end
