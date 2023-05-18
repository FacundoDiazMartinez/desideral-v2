class Company::Delete
  def self.call(params)
    new(payload(params)).send(:execute)
  end

  def initialize(args)
    @id = args[:id]
  end

  private

  def payload params
    payload = ActionController::Parameters.new(params)
    payload.permit(:id)
  end

  def execute
    company = Company.find(@id)
    if company.destroy
      Result.success(true, :ok)
    else
      Result.failure(company.errors, :unprocessable_entity)
    end
  rescue => e
    Result.failure(e, :unprocessable_entity)
  end
end
