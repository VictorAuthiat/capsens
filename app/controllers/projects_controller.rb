class ProjectsController < ApplicationController
  def index
    @q = Project.all.where(aasm_state: %w[upgoing ongoing success]).ransack(params[:q])
    @projects = @q.result
  end

  def show
    @project = Project.find(params[:id])
    @contribution = Contribution.new
  end

  def success
    @q = Project.all.where(aasm_state: %w[success]).ransack(params[:q])
    @projects = @q.result
  end

  def upcoming
    @q = Project.all.where(aasm_state: %w[upgoing]).ransack(params[:q])
    @projects = @q.result
  end

  def ongoing
    @q = Project.all.where(aasm_state: %w[ongoing]).ransack(params[:q])
    @projects = @q.result
  end

  def search
    index
    render :index
  end
end
