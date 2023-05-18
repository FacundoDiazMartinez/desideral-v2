class Product::Update
  def self.call(user:, id:, payload:)
    new(user, id, payload).send(:execute)
  end

  def initialize(user, id, payload)
    @user = user
    @id = id
    @payload = update_params(payload.to_enum.to_h)
  end

  private

  def execute
    product = @user.company.products.find(@id)

    if product.update(**@payload, company_id: @user.company_id)
      Result.success(product, :ok)
    else
      Result.failure(product.errors.full_messages, :unprocessable_entity)
    end
  rescue => e
    Result.failure(e.message, :unprocessable_entity)
  end

  def update_params(payload)
    ActionController::Parameters.new(payload)
      .permit(:name, :description, :price, :stock, :unit, :category_id,
              :default_tax, :model, :code, :company_id)
  end
end
