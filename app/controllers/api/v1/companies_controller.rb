class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    result = Company::List.call(params)

    render_result(result)
  end

  def show
    return render_result(Company::Show.call(current_user)) if current_user.company_id
    render_result(Company::New.call)
  end

  def create
    result = Company::Create.call(current_user, params)

    render_result(result)
  end

  def update
    result = Company::Update.call(params)

    render_result(result)
  end

  def destroy
    result = Company::Delete.call(params)

    render_result(result)
  end
end
