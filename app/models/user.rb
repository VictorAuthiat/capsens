class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :contributions, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true
  validates :email, presence: true
  validates :country_of_residence, presence: true
  validates :nationality, presence: true

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
end
