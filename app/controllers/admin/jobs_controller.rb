class Admin::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_job, only: [:show, :edit, :update, :destroy, :publish, :hide]

  def index
    @jobs = Job.all
  end

  def show
    @resumes = @job.resumes.order('created_at DESC')
  end

  def edit
  end

  def new
    @job = Job.new
    @job.contact_email = current_user.email
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy

    redirect_to admin_jobs_path, alert: "Job Deleted"
  end

  def publish
    @job.publish!
    redirect_to :back
  end

  def hide
    @job.hide!
    redirect_to :back
  end

  private

  def find_job
    @job = Job.find(params[:id])
  end

  def require_is_admin
    unless current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end

end
