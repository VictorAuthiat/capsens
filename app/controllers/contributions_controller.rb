class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.new(contribution_params)
    @project = Project.find(params[:project_id].to_i)
    @contribution.user_id = current_user.id
    @contribution.project_id = @project.id
    @counterpart = @project.counterparts.first
    @contribution.counterpart_id = @counterpart.id
    if @contribution.save
      redirect_to edit_contribution_path(@contribution)
    else
      redirect_to project_path(@project)
    end
  end

  def edit
    @contribution = Contribution.find(params[:id])
    @project = Project.find(@contribution.project_id)
    @counterparts = @project.counterparts.where('amount_in_cents < (?) AND amount_in_cents > (?)', @contribution.amount_in_cents, 0)
  end

  def update
    @contribution = Contribution.find(params[:id])
    @contribution.update(counterpart_id: params[:contribution][:counterpart_id])
    redirect_to dashboard_path
  end

  private

  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :project_id, :user_id, :counterpart_id)
  end
end
