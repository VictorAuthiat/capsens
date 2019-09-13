class ProjectPercentage < Transaction
  step :validate

  private

  def validate(input)
    @project = input[:project]
    @contribution_sum = input[:contribution_sum]
    if @contribution_sum >= 100
      @contribution_sum = 100
      @project.update(aasm_state: 'success')
      Success(input)
    else
      Failure(input)
    end
  end
end
