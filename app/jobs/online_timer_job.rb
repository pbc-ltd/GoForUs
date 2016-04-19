class OnlineTimerJob < ActiveJob::Base
  queue_as :default

  # If the user is inactive for more than 30 minutes we class them
  # as offline & not available for orders
  def perform(user, last_check_time)
    return unless user.online
    last_check_time = Time.at(last_check_time).to_s

    if user.updated_at < (DateTime.parse(last_check_time) + 15.minutes)
      user.update(online: false, available: false)
      user.send_updated_gcm_message
    else
      OnlineTimerJob.set(wait: 15.minutes).perform_later(user, DateTime.now.to_i)
    end
  end
end
