class Address < ApplicationRecord
  belongs_to :addressable, -> { unscope(where: :available) }, polymorphic: true, optional: true

  validates :street_number, presence: true, length: { maximum: 100, minimum: 1 }
  validates :street_name, presence: true, length: { maximum: 100, minimum: 1 }
  validates :city, presence: true, length: { maximum: 100, minimum: 1 }
  validates :state, presence: true, length: { maximum: 100, minimum: 1 }
  validates :country,
    presence: true,
    length: { maximum: 100, minimum: 1 },
    inclusion: { in: AvailableCountry::LIST, message: "%{value} no es un país válido" }
  validates :post_code, presence: true, length: { maximum: 100, minimum: 1 }

  def full_address
    "#{street_name} #{street_number}, #{city}, #{state}, #{country}, #{post_code}"
  end
end
