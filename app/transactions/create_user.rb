class CreateUser < Transaction

  step :validate
  tee :create
  tee :email
  tee :login

  private

  def validate(input)
    input[:user].valid? ? Success(input) : Failure(input.merge(error: input[:user].errors.full_messages.uniq.join('. ')))
  end

  def create(input)
    input[:user].save
  end

  def email(input)
    PostMailer.new_message("no-reply@capsens.eu", input[:user].email).deliver_now
  end

  def login
  end
end
