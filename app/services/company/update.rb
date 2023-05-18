class Company::Update
  def self.call(payload)
    new(payload).send(:execute)
  end

  def initialize(payload)
    @id = payload[:id]
    @payload = payload[:company].to_enum.to_h
    if (@payload.key?("address"))
      @payload[:address_attributes] = @payload.delete("address")
    end
  end

  def update_params
    ActionController::Parameters.new(@payload)
      .permit(:name, :iva_status, :id_number, :business_name, :phone_number, :email, :logo,
              address_attributes: [:country, :state, :city, :street_name, :street_number, :post_code])
  end

  private

  def execute
    company = Company.find(@id)

    if company.update(update_params.except(:address_attributes))
      if update_params.key?(:address_attributes)
        address = company.address || company.build_address
        address.update(update_params[:address_attributes])
      end
      Result.success(company.as_json(include: :address), :ok)
    else
      Result.failure(company.errors.full_messages, :unprocessable_entity)
    end
  rescue => e
    Result.failure(e.message, :unprocessable_entity)
  end
end
