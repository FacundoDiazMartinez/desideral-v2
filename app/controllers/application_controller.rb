class ApplicationController < ActionController::API
  def current_user
    token = request.headers["Authorization"]&.split(" ")&.last
    return nil unless token
    user_id = JWT.decode(token, Rails.application.secrets.secret_key_base.to_s)[0]["user_id"]
    @current_user ||= User.find(user_id)
  end

  def authenticate_user!
    head :unauthorized unless current_user
  end

  def render_result(result)
    if result.success?
      render json: result.value, status: result.status
    else
      render json: result.error, status: result.status
    end
  end
end
