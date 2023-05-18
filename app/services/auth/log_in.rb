class Auth::LogIn
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.call(email:, password:)
    new(email: email, password: password).send(:execute)
  end

  private

  def initialize(email:, password: )
    @email = email
    @password = password
  end

  def execute
    if user&.authenticate(@password)
      Result.success({ 
        user: user, 
        token: JWT.encode({user_id: user.id}, SECRET_KEY) 
      }, :ok)
    else
      Result.failure({ errors: "Invalid email or password" }, :unauthorized)
    end
  end

  def user = @user ||= User.find_by(email: @email)

end