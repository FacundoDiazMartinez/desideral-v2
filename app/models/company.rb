class Company < ApplicationRecord
  include Addressable
  include ImageProcessor
  has_image :logo, size: [300, 300]

  has_many :users
  has_many :categories, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :available }
  validates :iva_status, presence: true
  validates :id_number, presence: true, uniqueness: { scope: :available }
  validates :business_name, presence: true, uniqueness: { scope: :available }
  validates :phone_number, presence: true
  validates :email, presence: true, uniqueness: { scope: :available }, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum iva_status: { monotributo: 0, responsable_inscripto: 1, exento: 2 }

  default_scope { where(available: true) }

  before_destroy :unlink_users, prepend: true

  def as_json(options = {})
    super.merge(logo: logo_url)
  end

  def self.search(search)
    if search
      where("name ILIKE :search", search: "%#{search}%")
    else
      all
    end
  end

  def unlink_users
    users.update_all(company_id: nil)
  end

  def products
    Product.includes(:category).where(available: true, categories: { company_id: self.id }).or(
      Product.where(available: true, company_id: self.id)
    )
  end

  def self.categories
    Category.where(company_id: self.id)
  end
end
