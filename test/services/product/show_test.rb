class Product::ShowTest < ActiveSupport::TestCase
  test "show product" do
    company = companies(:one)
    product = products(:one)
    result = Product::Show.call(company: company, id: product.id)
    assert result.success?
    assert result.value == product
  end

  test "show product not found" do
    company = companies(:one)
    result = Product::Show.call(company: company, id: 0)
    assert_not result.success?
    assert result.error == { errors: "No se encuentra el producto" }
  end
end
