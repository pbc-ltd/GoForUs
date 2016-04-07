class Vehicle < ActiveRecord::Base
  VEHICLE_TYPES = ["Scooter", "Road Bike", "Standard Car", "Small Van", "Large Van"]

  belongs_to :partner

  validates_presence_of :registration, :make, :model, :type, :partner_id
  validates_uniqueness_of :registration
  validates_inclusion_of :type, in: VEHICLE_TYPES
end
