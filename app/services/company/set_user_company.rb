class Company::SetUserCompany
  def self.call(user_id:, company_params:)
    new(user_id, company_params).send(:execute)
  end

  def initialize(user_id, company_params)
    @user_id = user_id || raise(ArgumentError, "Missing user_id")
    @company = company_params || raise(ArgumentError, "Missing company")
  end

  private

  def execute
    ActiveRecord::Base.transaction do
      user = User.find_by(id: @user_id)
      return Result.failure("User not found", :not_found) if !user
      company = Company::Create.call(user, { company: @company })
      return Result.failure("Couldn't create company", :unprocessable_entity) if !company.success?
      user.company_id = company.value.id
      if user.save
        Result.success(true, :ok)
      else
        Result.failure(user.errors.full_messages, :unprocessable_entity)
      end
    end
  rescue => e
    Result.failure(e, :unprocessable_entity)
  end
end
