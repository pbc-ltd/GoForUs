class OnlineTimerJob < ActiveJob::Base
  queue_as :default

  # If the user is inactive for more than 30 minutes we class them
  # as offline & not available for orders
  def perform(user, last_check_time)
    return unless user.online

    if user.updated_at < (last_check_time + 15.minutes)
      user.update(online: false, available: false)
    else
      OnlineTimerJob.set(wait: 15.minutes).perform_later(user, DateTime.now)
    end
  end
end
