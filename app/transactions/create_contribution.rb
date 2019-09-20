class CreateContribution < Transaction
  step :create

  private

  def create(input)
    @contribution = input[:contribution]
    if @contribution.bankwire
      transaction = CreateBankwireContribution.new.call(contribution: @contribution, project_id: input[:project_id], user: input[:user])
      if transaction.success?
        Success(input.merge(redirect: transaction.success[:redirect]))
      else
        flash[:error] = transaction.failure[:error]
        Failure(input.merge(redirect: transaction.failure[:project]))
      end
    else
      transaction = CreateCardContribution.new.call(contribution: @contribution, project_id: input[:project_id], user: input[:user])
      if transaction.success?
        Success(input.merge(redirect: transaction.success[:redirect]))
      else
        flash[:error] = transaction.failure[:error]
        Failure(input.merge(redirect: project_path(transaction.failure[:project])))
      end
    end
  end
end
