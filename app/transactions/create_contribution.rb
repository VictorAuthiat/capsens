class CreateContribution < Transaction
  step :validate
  tee :create
  step :test_card_web
  step :transfer_to_contribution_wallet

  private

  def validate(input)
    @contribution = input[:contribution]
    if @contribution.amount_in_cents.nil?
      Failure(input.merge(project: input[:project_id].to_i, error: "Amount can't be blank!"))
    else
      @project = Project.find(input[:project_id].to_i)
      @contribution.user_id = input[:user]
      @contribution.project_id = @project.id
      @counterpart = @project.counterparts.first
      @contribution.counterpart_id = @counterpart.id
      @user = @contribution.user
      Success(input)
    end
  end

  def create(input)
   @contribution.save
  end
      # On envoie l'utilisateur sur la page Mango pour qu'il renseigne sa CB
  # On cree un PayIn
  def test_card_web
    card_web = MangoPay::PayIn::Card::Web.create(
      'AuthorId': @user.mango_pay_id,
      'CreditedUserId': @user.mango_pay_id,
      'CreditedWalletId': @user.wallet_id,
      'DebitedFunds': { Currency: 'EUR', Amount: 0 },
      'Fees': { Currency: 'EUR', Amount: 0 },
      'CardType': 'CB_VISA_MASTERCARD',
      'ReturnURL': 'http://localhost:3000/projects',
      'Culture': (@user.country_of_residence == 'FR' ? 'FR' : 'EN'),
      'Tag': 'PayIn/Card/Web'
    )
    # Mango nous renvoie le resultat (paiement en succes / echec)
    if card_web['Status'] == 'FAILED'
      Failure({ contribution: @contribution }.merge(error: 'mango_pay_error_card', project: @contribution.project_id))
    else
      @contribution.update(state: 'payment_pending')
      Success(input.merge(redirect: response['RedirectURL']))
    end
  end

  def transfer_to_contribution_wallet(input)
    transfer = MangoPay::Transfer.create(
      AuthorId: @user.mango_pay_id,
      DebitedFunds: { Currency: 'EUR', Amount: @user.wallet_balance },
      Fees: { Currency: 'EUR', Amount: 0 },
      DebitedWalletID: @user.wallet_id,
      CreditedWalletID: @contribution.wallet_id,
      Tag: "User: #{@user.id}"
    )
    transfer ? Success(input) : Failure(error: 'mango_pay_error_transfer', project: @contribution.project_id)
  end
end
