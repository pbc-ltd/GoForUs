class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Allow searching  by location
  acts_as_geolocated lat: 'lat', lng: 'lng'

  # STI
  self.inheritance_column = :user_type

  def inbox
    []
  end
end
