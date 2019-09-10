class ProjectsController < ApplicationController
  def index
    @projects = Project.all.where(aasm_state: %w[upgoing ongoing success])
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end
 end
