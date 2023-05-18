class ListTest < ActiveSupport::TestCase
  test "should list companies" do
    companies = Company::List.call({page: 1, limit: 10})
    assert companies.success?
    assert_equal 2, companies.value.size
  end

  test "should list companies with filters" do
    companies = Company::List.call({page: 1, limit: 10, search: "Company One"})
    assert companies.success?
    assert_equal 1, companies.value.size
  end

  test "should not list companies with invalid filters" do
    companies = Company::List.call({page: 1, limit: 10, search: "invalid"})
    assert companies.success?
    assert_equal 0, companies.value.size
  end

  test "should not list companies with invalid page" do
    companies = Company::List.call({page: -1, limit: 10})
    assert_not companies.success?
    assert_equal :unprocessable_entity, companies.status
  end

  test "should not list companies with invalid limit" do
    companies = Company::List.call({page: 1, limit: 101})
    assert_not companies.success?
    assert_equal :unprocessable_entity, companies.status
  end
end
