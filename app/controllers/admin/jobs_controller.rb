class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_is_admin
  layout "admin"

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = "Job created"
      redirect_to admin_jobs_path
    else
      render :new
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
      redirect_to admin_jobs_path
    else
      render "admin/edit"
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.destroy
      flash[:alert] = "Job deleted"
      redirect_to admin_jobs_path
    end
  end

  def hide
    @job = Job.find(params[:id])
    @job.update(:is_hidden => true)
    @job.save!
    redirect_to admin_jobs_path
  end

  def public
    @job = Job.find(params[:id])
    @job.update(:is_hidden => false)
    @job.save!
    redirect_to admin_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end

  def require_is_admin
    if !current_user.is_admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

end
