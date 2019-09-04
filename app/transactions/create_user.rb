class CreateUser < Transaction

  step :validate
  step :create
  tee :email
  tee :login

  private

  def validate(input)
    input[:user].valid? ? Success(input) : Failure(input)
  end

  def create(input)
    if input[:user].save
      Success(input)
    else
      errors = @user.errors.full_messages.uniq
      Failure(input)
    end
  end

  def email(input)
    PostMailer.new_message("no-reply@capsens.eu", input[:user].email).deliver_now
  end

  def login
  end
end
