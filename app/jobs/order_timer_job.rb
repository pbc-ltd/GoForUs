class OrderTimerJob < ActiveJob::Base
  queue_as :default

  def perform(order)
    if !order.responded_to && !order.job.responded_to
      job = order.job
      job.accepted = false
      job.declined = true
      job.responded_to = true
      job.save
      order.update(accepted: false, responded_to: false)
    end
  end
end
