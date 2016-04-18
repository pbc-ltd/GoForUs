class Api::V1::JobsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false
Customer
  # GET /api/v1/jobs
  def index
    render json: user.jobs.map(&:to_hash)
  end

  # PUT /api/v1/jobs/:id/accept
  def accept
    @job = user.jobs.find(job_params[:id])

    if @job
      if @job.cancelled
        render json: { status: 'failed', message: 'This job has already been cancelled' }
      else
        @job.accepted = true
        @job.declined = false
        @job.responded_to = true

        if @job.save && @job.order.update(accepted: true, declined: false, responded_to: true)
          render json: { status: 'success', message: 'Job Accepted' }
        end
      end
    else
      render json: { status: 'failed', message: 'Unable to find job' }
    end
  end

  # PUT /api/v1/jobs/:id/decline
  def decline
    @job = user.jobs.find(job_params[:id])

    if @job
      if @job.accepted
        render json: { status: 'failed', message: 'This job has already been accepted' }
      else
        @job.accepted = false
        @job.declined = true
        @job.responded_to = true

        if @job.save && @job.order.update(accepted: false, declined: true, responded_to: true)
          render json: { status: 'success', message: 'Job Declined' }
        end
      end
    else
      render json: { status: 'failed', message: 'Unable to find job' }
    end
  end

  private
  def job_params
    params.permit(:id)
  end
end
