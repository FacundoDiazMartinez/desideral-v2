class Tax < ApplicationRecord
  belongs_to :taxeable, polymorphic: true
end
