class Product::Create
  def self.call(company, params)
    new(company, params).send(:execute)
  end

  def initialize(company, params)
    @company = company
    @params = params[:product].to_enum.to_h
  end

  private

  def create_params
    ActionController::Parameters.new(@params)
      .permit(:name, :description, :price, :category_id, :image, :model, :code, :tax,
              :stock, :unit, pictures: [])
  end

  def execute
    set_product
    return Result.success(@product, :created) if @product.persisted?
    @product.errors.add(:base, "Revise por favor")
    Result.failure({ product: @product.as_json(include: :image), errors: @product.errors }, :unprocessable_entity)
  end

  def set_product
    ActiveRecord::Base.transaction do
      @product = @company
        .products
        .where(company_id: @company.id, name: create_params[:name])
        .first_or_initialize(create_params)
      @product.save
    end
  end
end
