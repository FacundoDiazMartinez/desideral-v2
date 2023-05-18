class Api::V1::SessionsController < ApplicationController
  def log_in
    user = params[:user]
    result = Auth::LogIn.call(email: user[:email], password: user[:password])
    if result.success?
      render json: result.value, status: result.status
    else
      render json: result.error, status: result.status
    end
  end

  def sign_up
    user = params[:user]
    result = Auth::SignUp.call(
      first_name: user[:first_name],
      last_name: user[:last_name],
      email: user[:email],
      password: user[:password]
    )
    if result.success?
      render json: result.value, status: result.status
    else
      render json: result.error, status: result.status
    end
  end

  def me
    render json: current_user, status: :ok
  end

  private

  def log_in_params
    params.require(:user).permit(:email, :password)
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end