class Company::UpdateTest < ActiveSupport::TestCase
  def company_params
    {
      id: Company.first.id,
      company: {
        name: "Company Three",
        iva_status: "responsable_inscripto",
        id_number: "1234567890",
        business_name: "Company One S.A.",
        phone_number: "1234567890",
        email: "company_three@gmail.com",
        address_attributes: {
          country: "Argentina",
          state: "Buenos Aires",
          city: "La Plata",
          street_name: "Street One",
          street_number: "123",
          post_code: "12345",
        },
      },
    }
  end

  test "should update company" do
    address = addresses(:one)
    result = Company::Update.call(company_params)
    assert result.success?
    assert_equal "Company Three", result.value["name"]
    assert_equal "responsable_inscripto", result.value["iva_status"]
    assert_equal "1234567890", result.value["id_number"]
    assert_equal "Company One S.A.", result.value["business_name"]
    assert_equal "1234567890", result.value["phone_number"]
    assert_equal "company_three@gmail.com", result.value["email"]
    assert_equal "Argentina", result.value["address"]["country"]
    assert_equal "Buenos Aires", result.value["address"]["state"]
    assert_equal "La Plata", result.value["address"]["city"]
    assert_equal "Street One", result.value["address"]["street_name"]
    assert_equal "123", result.value["address"]["street_number"]
    assert_equal "12345", result.value["address"]["post_code"]
  end

  [:name, :iva_status, :id_number, :business_name, :phone_number, :email].each do |field|
    test "should not update company with invalid #{field}" do
      company = Company.first
      result = Company::Update.call({ id: company.id, company: { field => nil } })
      assert_not result.success?
      assert "#{field.to_s.humanize} no puede estar en blanco".in?(result.error)
    end
  end

  test "should not update company with unpermitted params" do
    company = Company.first
    result = Company::Update.call({ company: { id: 0 } })
    assert !result.success?
  end
end
