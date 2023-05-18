class Product::Show
  def self.call(company:, id:)
    new(company: company, id: id).send(:execute)
  end

  def initialize(company:, id:)
    @company = company
    @id = id
  end

  private

  def execute
    set_product
    return Result.success(@product, :ok) if @product
  rescue ActiveRecord::RecordNotFound
    Result.failure({ errors: "No se encuentra el producto" }, :not_found)
  end

  def set_product
    @product = @company.products.find(@id)
  end
end
