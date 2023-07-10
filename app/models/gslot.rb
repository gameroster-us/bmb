class Gslot < ApplicationRecord
  belongs_to :ground 
  has_many :booking, dependent: :destroy
  validates_presence_of :start_time, :date, :ground_id , :charge
  validates_uniqueness_of :start_time, scope: [:date , :ground_id]
  def self.ransackable_attributes(auth_object = nil)
    ["charge", "date",  "end_time", "ground_id", "id", "inprocess", "start_time"]
  end
end
  