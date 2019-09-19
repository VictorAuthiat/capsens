class ProjectDecorator < BaseDecorator
  def state_badge
    if aasm_state == 'success'
      'success'
    elsif aasm_state == 'failure'
      'failure'
    else
      'up'
    end
  end

  def sum
    contributions.pluck(:amount_in_cents).sum
  end

  def percentage
    contribution_sum = (sum * 100).fdiv(purpose).round
    contribution_sum = 100 if contribution_sum > 100
    ProjectPercentage.new.call(project: self, contribution_sum: contribution_sum)
    contribution_sum
  end
end
