class Product < ApplicationRecord
  include ImageProcessor
  has_many_images :image, size: [300, 300]

  belongs_to :company
  belongs_to :category, optional: true

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :company_id, presence: true, if: -> { available? }

  default_scope { where(available: true) }
  scope :with_stock, -> { where("stock > 0") }

  enum unit: [:unit, :kilogram, :liter, :meter]
  enum :default_tax, { "0" => 0, "10.5" => 1, "21" => 2, "27" => 3 }

  def main_image
    image_urls&.first || "/images/default-product.jpg"
  end

  def as_json(options = {})
    super.merge(image: main_image)
  end
end
