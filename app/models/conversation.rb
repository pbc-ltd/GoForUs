class Conversation < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :job

  has_many :messages

  validates_presence_of :partner, :partner_id, :customer, :customer

  def has_offer_attached?
    !!offer
  end
end
