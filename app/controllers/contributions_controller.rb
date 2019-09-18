class ContributionsController < ApplicationController
  def create
    @contribution = Contribution.new(contribution_params)
    if @contribution.bankwire
      transaction = CreateBankwireContribution.new.call(contribution: @contribution, project_id: params[:project_id], user: current_user.id)
      if transaction.success?
        @bill = Bill.new
        bill_transaction = CreateBill.new.call(contribution: @contribution, content: transaction.success[:content], bill: @bill)
        if bill_transaction.success?
          redirect_to bill_path(@bill)
        else
          redirect_to dashboard_path
        end
      else
        flash[:error] = transaction.failure[:error]
        redirect_to project_path(transaction.failure[:project])
      end
    else
      transaction = CreateContribution.new.call(contribution: @contribution, project_id: params[:project_id], user: current_user.id)
      if transaction.success?
        redirect_to transaction.success[:redirect]
      else
        flash[:error] = transaction.failure[:error]
        redirect_to project_path(transaction.failure[:project])
      end
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def edit
    @contribution = Contribution.find(params[:id])
    @project = Project.find(@contribution.project_id)
    @counterparts = @project.counterparts.where('amount_in_cents < (?) AND amount_in_cents > (?)', @contribution.amount_in_cents, 0)
  end

  def update
    @user = current_user
    @contribution = Contribution.find(params[:id])
    @contribution.update(counterpart_id: params[:contribution][:counterpart_id])
    UpdateUserCounterpartsCount.new.call(user: @user)
    redirect_to dashboard_path
  end

  private

  def contribution_params
    params.require(:contribution).permit(:amount_in_cents, :counterpart_id, :bankwire)
  end
end
