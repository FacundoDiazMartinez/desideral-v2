class Product::List
  def self.call(company:, filter: {})
    new(company, filter).send(:execute)
  end

  def initialize(company, filter)
    @company = company
    @filter = filter_params(filter.to_enum.to_h)
  end

  private

  def filter_params(filter)
    ActionController::Parameters.new(filter)
      .permit(:name, :description, :price_min, :price_max, :category_id,
              :stock_min, :stock_max, :unit, :order_by, :page, :per_page,
              :with_stock)
  end

  def execute
    set_products
    Result.success(@products)
  rescue => e
    Result.failure(e.message)
  end

  def set_products
    per_page = @filter[:per_page] || 10
    page = @filter[:page] || 1
    @products = @company.products
    @products = @products.where(code: @filter[:code]) if @filter[:code].present?
    @products = @products.where(model: @filter[:model]) if @filter[:model].present?
    @products = @products.where(category_id: @filter[:category_id]) if @filter[:category_id].present?
    @products = @products.with_stock if @filter[:with_stock].present?
    @products = @products.where("products.name ILIKE ?", "%#{@filter[:name]}%") if @filter[:name]
    @products = @products.where("products.description ILIKE ?", "%#{@filter[:description]}%") if @filter[:description]
    @products = @products.where("products.price >= ?", @filter[:price_min]) if @filter[:price_min].present?
    @products = @products.where("products.price <= ?", @filter[:price_max]) if @filter[:price_max].present?
    @products = @products.where(unit: @filter[:unit]) if @filter[:unit].present?
    @products = @products.where("products.stock >= ?", @filter[:stock_min]) if @filter[:stock_min].present?
    @products = @products.where("products.stock <= ?", @filter[:stock_max]) if @filter[:stock_max].present?
    @products = @products.order(:created_at) if @filter[:order_by] == "created_at"
    @products = @products.order(:price) if @filter[:order_by] == "price"
    @products = @products.order(:name) if @filter[:order_by] == "name"
    @products = @products.order(:stock) if @filter[:order_by] == "stock"
    @products = @products.order(:updated_at) if @filter[:order_by] == "updated_at"
    @products = @products.offset((page.to_i - 1) * per_page).take(per_page)
  end
end
