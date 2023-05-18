class Admin < User
  belongs_to :company, -> { unscope(where: :available) }
  validates :company_id, presence: true, if: -> { available }

  default_scope { where(role: :admin, available: true) }
end
