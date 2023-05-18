class Company::SetUserCompanyTest < ActiveSupport::TestCase
  def company_params
    {
      name: "Company Three",
      iva_status: "responsable_inscripto",
      id_number: "1234567890",
      business_name: "Company One S.A.",
      phone_number: "1234567890",
      email: "company_three@email.com",
      address_attributes: {
        country: "Argentina",
        state: "Buenos Aires",
        city: "La Plata",
        street_name: "Street One",
        street_number: "123",
        post_code: "12345",
      },
    }
  end

  test "should set user company" do
    user = User.first
    result = Company::SetUserCompany.call(user_id: user.id, company_params: company_params)
    assert result.success?
    assert_equal company_params[:name], user.reload.company.name
  end

  test "should not set user company with invalid user" do
    result = Company::SetUserCompany.call(user_id: 0, company_params: company_params)
    assert_not result.success?
    assert_equal "User not found", result.error
  end

  test "should not set user company with invalid company" do
    user = User.first
    result = Company::SetUserCompany.call(user_id: user.id, company_params: {})
    assert_not result.success?
    assert_equal "Couldn't create company", result.error
  end

  test "should not set user company with invalid params" do
    result = Company::SetUserCompany.call(user_id: 0, company_params: 0)
    assert_not result.success?
    assert_equal "User not found", result.error
  end
end
