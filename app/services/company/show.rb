class Company::Show
  def self.call(user)
    new(user.company).send(:execute)
  end

  def initialize(company)
    @company = company
  end

  private

  def execute
    return Result.failure("No company found", :not_found) unless @company
    Result.success(@company.to_json(include: [:address]), :ok)
  end
end
