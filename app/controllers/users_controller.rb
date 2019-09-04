class UsersController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    transaction = CreateUser.new.call(user: user)
    if transaction.success?
      flash[:alert] = "Good!"
      redirect_to root_path
    else
      flash[:alert] = "Bad!"
      render :new
    end
  end
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
