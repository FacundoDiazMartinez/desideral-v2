class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = Product::List.call(company: current_user.company, filter: params)
    render_result(result)
  end

  def show
    result = Product::Show.call(company: current_user.company, id: params[:id])
    render_result(result)
  end

  def create
    result = Product::Create.call(current_user.company, params)
    render_result(result)
  end

  def update
    result = Product::Update.call(user: current_user, id: params[:id], payload: params[:product])
    render_result(result)
  end
end
