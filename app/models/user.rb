class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Allow searching  by location
  acts_as_geolocated lat: 'lat', lng: 'lng'

  # STI
  self.inheritance_column = :user_type
end
