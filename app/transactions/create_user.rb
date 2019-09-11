class CreateUser < Transaction
  step :validate
  tee :create
  tee :mango_pay_user_create
  tee :email

  private

  def validate(input)
    input[:user].valid? ? Success(input) : Failure(input.merge(error: input[:user].errors.full_messages.uniq.join('. ')))
  end

  def create(input)
    input[:user].save
  end

  def mango_pay_user_create(input)
    user = input[:user]
    a = MangoPay::NaturalUser.create(
      'FirstName': user.first_name,
      'LastName': user.last_name,
      'Birthday': user.birthday.to_i,
      'Nationality': user.nationality,
      'CountryOfResidence': user.country_of_residence,
      'Email': user.email
    )
    a
  end

  def email(input)
    PostMailer.new_message("no-reply@capsens.eu", input[:user].email).deliver_now
  end
end
