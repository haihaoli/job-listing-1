class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.where(:is_hidden => false).order("wage_lower_bound DESC")
            when 'by_upper_bound'
              Job.where(:is_hidden => false).order("wage_upper_bound DESC")
            else
              Job.where(:is_hidden => false).order("created_at DESC")
            end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new
    if @job.save(job_params)
      flash[:notice] = "Job created"
      redirect_to jobs_path
    else
      render "new"
    end
  end

  def show
    @job = Job.where(:is_hidden => false).find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:notice] = "Job Updated"
      redirect_to jobs_path
    else
      render "edit"
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:alert] = "Job deleted"
      redirect_to jobs_path
    end
  end

  protected

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
