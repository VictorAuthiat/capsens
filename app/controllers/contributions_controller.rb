class ContributionsController < ApplicationController
  def new
    @contribution = Contribution.new
  end
  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    if @contribution.save
      redirect_to project_path(@contribution.project_id)
    else
      render :new
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :project_id, :user_id, :counterpart_id)
  end
end
