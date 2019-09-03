class CreateUser < Transaction
  include Dry::Transaction

  step :validate
  step :create
  step :email

  private

  def validate(input)
    input.values.first.valid? ? Success(input) : Failure(input)
  end

  def create(input)
    input[:user].save
  end

  def email(input)
  end
end
