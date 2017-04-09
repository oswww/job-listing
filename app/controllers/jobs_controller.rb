class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def edit
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy

    redirect_to jobs_path, alert: "Job Deleted"
  end

  private

  def find_job
    @job = Job.find(params[:id])
  end

  def check_admin
  end

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
