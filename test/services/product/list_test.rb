class Product::ListTest < ActiveSupport::TestCase
  test "list products" do
    company = companies(:one)

    filter = {}
    products = Product::List.call(company: company, filter: filter)
    assert products.success?
    assert products.value.count == company.products.count
  end

  test "list products with filter" do
    company = companies(:one)
    filter = { name: company.products.last.name }
    products = Product::List.call(company: company, filter: filter)
    assert products.success?
    assert products.value.count == 1
  end

  test "list products with filter and order" do
    company = companies(:one)

    filter = { name: company.products.last.name, order_by: "price" }
    products = Product::List.call(company: company, filter: filter)
    assert products.success?
    assert products.value.count == 1
  end

  test "list products with filter and order and pagination" do
    company = companies(:one)

    filter = { name: company.products.last.name, order_by: "price", page: 1, per_page: 1 }
    products = Product::List.call(company: company, filter: filter)
    assert products.success?
    assert products.value.count == 1
  end

  test "list products with filter and order and pagination and stock" do
    company = companies(:one)
    product = products(:one)
    filter = { name: product.name, order_by: "price", page: 1, per_page: 10, with_stock: true }
    products = Product::List.call(company: company, filter: filter)
    assert products.success?
    assert products.value.count == 1
  end
end
