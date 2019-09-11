class CreateContribution < Transaction
  step :validate
  tee :create

  private

  def validate(input)
    input[:contribution].amount_in_cents.nil? ? Failure(input.merge(project: input[:project_id].to_i, error: "Amount can't be blank!")) : Success(input)
  end

  def create(input)
    @project = Project.find(input[:project_id].to_i)
    input[:contribution].user_id = input[:user]
    input[:contribution].project_id = @project.id
    @counterpart = @project.counterparts.first
    input[:contribution].counterpart_id = @counterpart.id
    input[:contribution].save
  end
end
