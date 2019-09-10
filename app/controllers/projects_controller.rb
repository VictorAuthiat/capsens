class ProjectsController < ApplicationController
  def index
    @projects = Project.all.where(aasm_state: %w[upgoing ongoing success])
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end

  def create
    @project = Project.new
    @project.name = "rororo"
    if @project.save
      redirect_to project.path
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
