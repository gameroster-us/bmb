class Ground < ApplicationRecord
  belongs_to :organization
  has_many :gslots
end
