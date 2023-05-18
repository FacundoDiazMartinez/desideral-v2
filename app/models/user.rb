class User < ApplicationRecord
  belongs_to :company, optional: true
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  enum role: [:admin, :employee]

  default_scope { where(available: true) }

  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
