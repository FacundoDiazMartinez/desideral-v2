class Address::Create
  def self.call(payload)
    new(payload).send(:execute)
  end

  def initialize(args)
    @payload = args.to_enum.to_h.stringify_keys
  end

  private

  def create_params
    ActionController::Parameters.new(@payload)
      .permit(:street_name, :street_number, :city, :state, :country, :post_code)
  end

  def execute
    validate_required_parameters!
    return Result.success(address, :created) if address.persisted?
    Result.failure(address.errors, :unprocessable_entity)
  rescue ArgumentError => e
    Result.failure(e.message, :unprocessable_entity)
  end

  def address
    @address ||= Address.where(create_params).first_or_create
  end

  def validate_required_parameters!
    [:street_name, :street_number, :city, :state, :country, :post_code].each do |param|
      raise ArgumentError.new("Missing parameters: #{param}") unless @payload[param.to_s]
    end
  end
end
