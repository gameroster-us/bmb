class Organization < ApplicationRecord
    has_many :grounds, dependent: :destroy
end
  