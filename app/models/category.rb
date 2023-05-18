class Category < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :company

  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  default_scope { where(available: true) }
end
