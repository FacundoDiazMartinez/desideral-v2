class Company::List
  def self.call(params)
    list = new(payload(params)).send(:execute)
    Result.success(list, :ok)
  rescue => e
    Result.failure(e, :unprocessable_entity)
  end

  def initialize(args)
    @page = (args[:page] == 0) ? 1 : args[:page]
    @limit = (args[:limit] == 0) ? 10 : args[:limit]
    @search = args[:search]
  end

  def self.payload params
    payload = ActionController::Parameters.new(params)
    payload.permit(:page, :limit, :search)
  end

  private

  def execute
    validate
    companies = Company.search(@search).offset((@page - 1) * @limit).limit(@limit)
    companies.map do |company|
      {
        id: company.id,
        name: company.name,
        created_at: company.created_at,
        updated_at: company.updated_at
      }
    end
  end

  def validate
    raise "Invalid page" if @page < 1
    raise "Invalid limit" if @limit < 1 || @limit > 100
    raise "Invalid search" if @search&.size && @search.size > 100
  end
end
