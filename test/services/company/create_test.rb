class Company::CreateTest < ActiveSupport::TestCase
  def company_params
    {
      company: {
        name: "Company Three",
        business_name: "Company Three",
        id_number: "123456789",
        phone_number: "123456789",
        email: "company_three@email.com",
        iva_status: "monotributo",
        address_attributes: {
          street_name: "Street Three",
          street_number: "123",
          city: "City Three",
          state: "State Three",
          country: AvailableCountry::LIST.sample,
          post_code: "12345",
        },
      },
    }
  end

  def current_user
    @current_user ||= users(:one)
  end

  test "should create company" do
    company = Company::Create.call(current_user, company_params)
    assert company.success?
    assert_equal "Company Three", company.value.name
    assert company.value.address.present?
  end

  [:name, :iva_status, :id_number, :business_name, :phone_number].each do |param|
    test "should not create company without #{param}" do
      company = Company::Create.call(current_user, company_params.merge({ company: { param => nil } }))
      assert_not company.success?
      assert "#{param.to_s.humanize} no puede estar en blanco".in? company.error.try(:[], :errors).full_messages
    end
  end

  test "should not create company with invalid iva_status" do
    company = Company::Create.call(current_user, company_params.merge(company: { iva_status: "invalid" }))
    assert_not company.success?
    assert_equal "'invalid' is not a valid iva_status", company.error.message
  end

  test "should not create company with invalid email" do
    company = Company::Create.call(current_user, company_params.merge(company: { email: "invalid" }))
    assert_not company.success?
    assert "Email es inválido".in?(company.error[:errors].full_messages)
  end
end
