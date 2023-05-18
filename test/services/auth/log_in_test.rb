class Auth::LogInTest < ActiveSupport::TestCase
  test "success" do
    user = users(:one)
    result = Auth::LogIn.call(email: user.email, password: 'password')
    assert result.success?
    assert result.value[:token].present?
    assert_equal user, result.value[:user]
    assert result.status, :ok
  end

  test "failure" do
    result = Auth::LogIn.call(email: 'invalid', password: 'invalid')
    assert_not result.success?
    assert_equal 'Invalid email or password', result.error[:errors]
    assert result.status, :unauthorized
  end
end
