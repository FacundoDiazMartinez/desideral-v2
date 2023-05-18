class Image < ApplicationRecord
  belongs_to :company, -> { unscope(where: :available) }
  belongs_to :imageable, -> { unscope(where: :available) }, polymorphic: true

  validates :url, presence: true, length: {minimum: 3, maximum: 255}
  validates :imageable_id, presence: true, if: -> { available? }
  validates :imageable_type, presence: true, if: -> { available? }

  default_scope { where(available: true) }
end
