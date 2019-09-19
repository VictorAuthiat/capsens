class UserDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def contribution_sum
    paid_contributions = contributions.where(aasm_state: 'paid')
    paid_contributions.pluck(:amount_in_cents).sum.fdiv(100).round
  end

  def user_projects
    contributions.all.group_by(&:project)
  end

  def projects_count
    user_projects.count
  end
end
