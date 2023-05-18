class Product::CreateTest < ActiveSupport::TestCase
  def company
    @company ||= companies(:one)
  end

  def product_params
    {
      product: {
        name: "Product 1",
        price: 10.0,
        description: "Description",
      },
    }
  end

  test "create product" do
    product = Product::Create.call(company, product_params)
    assert product.success?
  end
end
