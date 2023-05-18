class Company::New
  def self.call
    new.send(:execute)
  end

  private

  def execute
    company = Company.new
    company.build_address
    Result.success(company, :ok)
  end
end
