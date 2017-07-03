class JobsController < ApplicationController
  def index
    @jobs = Job.all
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
    params.require(:job).permit(:title, :description)
  end
end
