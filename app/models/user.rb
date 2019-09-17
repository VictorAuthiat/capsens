class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable, omniauth_providers: [:facebook]
  has_many :contributions, dependent: :destroy
  validates :birthday, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :country_of_residence, presence: true
  # validates :nationality, presence: true

  def contribution_sum
    paid_contributions = contributions.where(aasm_state: 'paid')
    paid_contributions.pluck(:amount_in_cents).sum.fdiv(100).round
  end

  def user_projects
    contributions.all.group_by(&:project)
  end

  def projects_count
    user_projects.count
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice('provider', 'uid')
    user_params.merge! auth.info.slice('email', 'first_name', 'last_name')
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params[:birthday] = Date.strptime(auth['extra']['raw_info']['birthday'], '%m/%d/%Y')
    user_params[:country_of_residence] = 'FR'
    user_params[:nationality] = 'FR'
    user_params = user_params.to_h
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email)
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]
      transaction = CreateUser.new.call(user: user)
      if transaction.success?
        sign_up(:user, user)
        redirect_to edit_user_path(user.id)
      else
        flash[:error] = transaction.failure[:error]
        render :new
      end
    end
    user
  end
end
