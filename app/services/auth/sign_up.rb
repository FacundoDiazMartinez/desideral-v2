class Auth::SignUp

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.call(first_name:, last_name:, email:, password:)
    new(first_name, last_name, email, password).send(:execute)
  end

  private

  def initialize(first_name, last_name, email, password)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @password = password
  end

  def execute
    user = User.new(
      first_name: @first_name,
      last_name: @last_name,
      email: @email,
      password: @password
    )

    if user.save
      Result.success({
        user: user, 
        token: JWT.encode({user_id: user.id}, SECRET_KEY)
      }, :created)
    else
      Result.failure(user.errors, :unprocessable_entity)
    end
  end
end