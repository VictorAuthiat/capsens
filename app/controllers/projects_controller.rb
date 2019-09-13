class ProjectsController < ApplicationController
  def index
    @q = Project.all.where(aasm_state: %w[upgoing ongoing success]).ransack(params[:q])
    @projects = @q.result
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end
end
