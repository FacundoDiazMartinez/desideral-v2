class Category::List
  def self.call(company:, filters: {})
    new(company, filters).send(:execute)
  end

  def initialize(company, filters)
    @company = company
    @filters = filter_params(filters.to_enum.to_h)
  end

  private

  def execute
    set_categories
    Result.success(@categories)
  rescue => e
    Result.failure(e.message)
  end

  def filter_params(filter)
    ActionController::Parameters.new(filter)
      .permit(:name, :description, :order_by)
  end

  def set_categories
    @categories = @company.categories
    @categories = @categories.where("categories.name ILIKE ?", "%#{@filters[:name]}%") if @filters[:name]
    @categories = @categories.where("categories.description ILIKE ?", "%#{@filters[:description]}%") if @filters[:description]
    @categories = @categories.order(:name) if !@filters[:order_by].present?
    @categories = @categories.order(:name) if @filters[:order_by] == "name"
    @categories = @categories.order(:created_at) if @filters[:order_by] == "created_at"
    @categories = @categories.order(:updated_at) if @filters[:order_by] == "updated_at"
  end
end
