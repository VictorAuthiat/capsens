class UsersController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    transaction = CreateUser.new.call(user: user)
    if transaction.failure?
      errors = user.errors.full_messages.uniq
      errors.each { |error| flash[:alert] = error }
      redirect_to new_user_registration_path
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
