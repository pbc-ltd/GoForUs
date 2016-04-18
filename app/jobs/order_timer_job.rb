class OrderTimerJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    unless order.responded_to
      job = order.job
      job.accepted = false
      job.declined = true
      job.responded_to = true
      job.save
      order.update(accepted: false, responded_to: false)
    end
  end
end
