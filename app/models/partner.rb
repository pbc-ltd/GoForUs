class Partner < ActiveRecord::Base
  include Deactivateable::Model

  has_many :orders
end