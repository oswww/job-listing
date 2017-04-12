class JobsController < ApplicationController
  before_action :find_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
    when "by_lower_bound"
      Job.published.order_by_wage_lower_bound
    when "by_upper_bound"
      Job.published.order_by_wage_upper_bound
    else
      Job.published.recent
    end
  end

  def show
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end

  private

  def find_job
    @job = Job.find(params[:id])
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
