class ProjectsController < ApplicationController
  def index
    @q = Project.all.where(aasm_state: %w[upgoing ongoing success]).ransack(params[:q])
    @projects = @q.result
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
    @project_decorator = helpers.decorate(@project)
  end

  def search
    index
    @projects = @q.result
    render :index
  end
end
