class Company::Create
  def self.call(current_user, payload)
    new(current_user, payload).send(:execute)
  rescue => e
    Result.failure(e, :unprocessable_entity)
  end

  def initialize(current_user, payload)
    @current_user = current_user
    @payload = payload[:company].to_enum.to_h
    if (@payload.key?(:address))
      @payload[:address_attributes] = @payload.delete(:address)
    end
  end

  private

  def create_params
    ActionController::Parameters.new(@payload)
      .permit(:name, :iva_status, :id_number, :business_name, :phone_number, :email, :logo,
              address_attributes: [:country, :state, :city, :street_name, :street_number, :post_code])
  end

  def execute
    set_company
    return Result.success(@company, :created) if @company.persisted?
    @company.errors.add(:base, "Revise por favor")
    Result.failure({ company: @company.as_json(include: :address), errors: error }, :unprocessable_entity)
  rescue => e
    Result.failure(e, :unprocessable_entity)
  end

  def set_company
    ActiveRecord::Base.transaction do
      @company = Company.where(name: create_params[:name]).first_or_initialize do |company|
        company.assign_attributes(create_params.except(:address_attributes))
      end
      if create_params[:address_attributes]
        address = Address::Create.call(create_params[:address_attributes])
        @company.address = address.value
      end
      @company.save && @current_user.update_attribute(:company_id, @company.id)
    end
  end

  def error
    @company.errors
  end
end
