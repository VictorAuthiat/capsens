class UsersController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    transaction = CreateUser.new.call(user: @user)
    if transaction.success?
      set_flash_message! :notice, :signed_up
      sign_up(:user, @user)
      redirect_to root_path
    else
      flash[:error] = transaction.failure[:error]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :birthday, :nationality, :country_of_residence)
  end
end
