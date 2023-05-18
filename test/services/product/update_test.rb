class Product::UpdateTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @company = companies(:one)
    @user = users(:one)
    @user.update(company: @company)
  end

  test "update product" do
    payload = { name: "New name" }
    result = Product::Update.call(user: @user, id: @product.id, payload: payload)
    assert result.success?
    assert_equal payload[:name], result.value["name"]
  end

  test "update product with invalid params" do
    payload = { name: "" }
    result = Product::Update.call(user: @user, id: @product.id, payload: payload)
    assert_not result.success?
    assert "Name no puede estar en blanco".in? result.error
  end
end
