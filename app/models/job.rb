class Job < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :order
end
