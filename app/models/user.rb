class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Allow searching  by location
  acts_as_geolocated lat: 'lat', lng: 'lng'
  # Messaging
  acts_as_messageable

  # STI
  self.inheritance_column = :user_type

  def inbox
    mailbox.inbox
  end

  def conversations
    mailbox.conversations
  end

  def sentbox
    mailbox.sentbox
  end

  def trash
    mailbox.trash
  end
end
