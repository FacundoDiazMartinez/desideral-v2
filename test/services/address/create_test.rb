class Address::CreateTest < ActiveSupport::TestCase
  def address_params
    {
      country: "Argentina",
      state: "Buenos Aires",
      city: "La Plata",
      street_name: "Street One",
      street_number: "123",
      post_code: "12345",
    }
  end

  test "should create address" do
    result = Address::Create.call(address_params)
    assert result.success?
    assert_equal Address.last.id, result.value.id
  end

  test "should not create address with invalid params" do
    user = User.first
    result = Address::Create.call({ id: nil })
    assert_not result.success?
    assert "Missing parameters".in?(result.error)
  end
end
