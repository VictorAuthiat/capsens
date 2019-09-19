class ProjectsController < ApplicationController
  decorates_assigned :project, :projects
  def index
    @q = Project.all.where(aasm_state: %w[upgoing ongoing success]).ransack(params[:q])
    @projects = @q.result
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end

  def search
    index
    @projects = @q.result
    render :index
  end
end
