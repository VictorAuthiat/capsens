class HookReceive < Transaction
  tee :init_hook

  private

  def init_hook(input)
    @contribution = Contribution.find_by(
      mango_pay_id: input[:parameters]['RessourceId']
    )
    @contribution.update(aasm_state: 'paid') if input[:parameters]['EventType'] == 'PAYIN_NORMAL_SUCCEEDED'
  end
end
