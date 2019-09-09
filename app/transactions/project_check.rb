class ProjectCheck < Transaction
  step :validate

  private
  def validate(input)
    @project = input[:project]
    if @project.aasm_state == 'draft'
      @project.may_up? && @project.up! ? Success(input) : Failure(input.merge(error: input[:project].errors.full_messages.uniq.join('. ')))
    elsif @project.aasm_state == 'upgoing'
      @project.may_on? && @project.on! ? Success(input) : Failure(input.merge(error: input[:project].errors.full_messages.uniq.join('. ')))
    end
  end
end
