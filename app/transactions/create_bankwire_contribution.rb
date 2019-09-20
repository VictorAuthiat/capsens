class CreateBankwireContribution < Transaction
  tee :initialize_contribution
  step :validate
  tee :create
  step :bankwire_payin

  private

  def initialize_contribution(input)
    @contribution = input[:contribution]
    @project = Project.find(input[:project_id].to_i)
    @contribution.user_id = input[:user]
    @contribution.project_id = @project.id
    @counterpart = @project.counterparts.first
    @contribution.counterpart_id = @counterpart.id
    @user = @contribution.user
  end

  def validate(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge(project: input[:project_id].to_i, error: "Amount can't be blank!"))
    end
  end

  def create(_input)
    @contribution.save
  end

  # On cree un PayIn
  def bankwire_payin(input)
    bankwire = MangoPay::PayIn::BankWire::Direct.create(
      {
        'AuthorId': @user.mango_pay_id,
        'CreditedUserId': @user.mango_pay_id,
        'CreditedWalletId': @user.wallet_id,
        'DeclaredDebitedFunds': {
          'Currency': "EUR",
          'Amount': @contribution.amount_in_cents
        },
        'DeclaredFees': {
          'Currency': "EUR",
          'Amount': 0
        }
      })
    if bankwire['Status'] == 'FAILED'
      Failure({ contribution: @contribution }.merge(error: 'mango_pay_error_bankwire', project: @contribution.project_id))
    else
      @contribution.update(aasm_state: 'payment_pending')
      @contribution.update(mango_pay_id: bankwire['Id'])
      Success(input.merge(redirect: Rails.application.routes.url_helpers.billing_path(content: bankwire.to_enum.to_h, contribution_id: @contribution.id)))
    end
  end
end
