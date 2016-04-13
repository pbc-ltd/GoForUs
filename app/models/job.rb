class Job < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :order

  def to_json
    {
      id: id,
      order_id: order_id,
      partner_id: partner_id,
      customer_id: customer_id,
      accepted: !!accepted,
      declined: !!declined,
      responded_to: !!responded_to
    }.to_json
  end
end
