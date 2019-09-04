class UsersController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    transaction = CreateUser.new.call(user: @user)
    if transaction.failure?
      flash[:errors] = resource.errors.full_messages.join(' . ')
      byebug
      render :new
    else
      set_flash_message! :notice, :signed_up
      sign_up(:user, user)
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
