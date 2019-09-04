class CreateUser < Transaction
  include Dry::Transaction

  step :validate
  step :create
  tee :email
  tee :login

  private

  def validate(input)
    input.values.first.valid? ? Success(input) : Failure(input)
  end

  def create(input)
    if input[:user].save
      Success(input)
    else
      Failure(input)
    end
  end

  def email(input)
    PostMailer.new_message("no-reply@capsens.eu", input[:user].email).deliver
  end

  def login
  end
end
