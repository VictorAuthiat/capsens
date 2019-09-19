class ContributionDecorator < BaseDecorator
  def state_badge
    if aasm_state == 'create'
      'create'
    elsif aasm_state == 'payment_pending'
      'pending'
    elsif aasm_state == 'paid'
      'paid'
    else
      'canceled'
    end
  end
end
