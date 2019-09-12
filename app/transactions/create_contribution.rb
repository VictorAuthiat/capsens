class CreateContribution < Transaction
  tee :initialize_contribution
  step :validate
  step :test_card_web
  tee :create

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
    if @contribution.amount_in_cents.nil?
      Failure(input.merge(project: input[:project_id].to_i, error: "Amount can't be blank!"))
    else
      Success(input)
    end
  end

  # On cree un PayIn
  def test_card_web(input)
    card_web = MangoPay::PayIn::Card::Web.create(
      'AuthorId': @user.mango_pay_id,
      'CreditedUserId': @user.mango_pay_id,
      'CreditedWalletId': @user.wallet_id,
      'DebitedFunds': { Currency: 'EUR', Amount: @contribution.amount_in_cents },
      'Fees': { Currency: 'EUR', Amount: 0 },
      'CardType': 'CB_VISA_MASTERCARD',
      'ReturnURL': "http://localhost:3000/projects",
      'Culture': (@user.country_of_residence == 'FR' ? 'FR' : 'EN'),
      'Tag': 'PayIn/Card/Web',
      "SecureMode": "DEFAULT",
      "TemplateURL": "http://www.a-url.com/3DS-redirect"
    )
    # On envoie l'utilisateur sur la page Mango pour qu'il renseigne sa CB
    # Mango nous renvoie le resultat (paiement en succes / echec)
    if card_web['Status'] == 'FAILED'
      Failure({ contribution: @contribution }.merge(error: 'mango_pay_error_card', project: @contribution.project_id))
    else
      @contribution.update(aasm_state: 'payment_pending')
      Success(input.merge(redirect: card_web['RedirectURL']))
    end
  end

  def create(_input)
    @contribution.save
  end
end
