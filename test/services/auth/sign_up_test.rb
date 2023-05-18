class Auth::SignUpTest < ActiveSupport::TestCase
  test "success" do
    result = Auth::SignUp.call(
      first_name: 'John',
      last_name: 'Doe',
      email: 'sample@email.com',
      password: 'password'
    )
    assert result.success?
    assert result.value[:token].present?
    assert result.value[:user].present?
    assert result.status, :created
  end

  test "failure" do
    result = Auth::SignUp.call(
      first_name: 'John',
      last_name: 'Doe',
      email: '',
      password: 'password'
    )
    assert_not result.success?
    assert result.error[:email].present?
    assert result.status, :unprocessable_entity
  end
end