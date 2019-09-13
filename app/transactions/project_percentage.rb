class ProjectPercentage < Transaction
  tee :validate

  private

  def validate(input)
    @project = input[:project]
    @contribution_sum = input[:contribution_sum]
    @project.update(aasm_state: 'success') if @contribution_sum >= 100
  end
end
