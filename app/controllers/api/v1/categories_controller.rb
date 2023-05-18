class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category::List.call(company: current_user.company, filters: params)
    render_result(@categories)
  end
end
