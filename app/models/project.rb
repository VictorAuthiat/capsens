class Project < ApplicationRecord
  include AASM
  include LandUploader::Attachment.new(:image)
  belongs_to :category
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  validates :name, presence: true
  validates :purpose, presence: true
  validates :content, presence: true
  validates :image, presence: true

  aasm do
    state :draft, initial: true
    state :upgoing
    state :ongoing
    state :success
    state :failure

    event :up do
      transitions from: :draft, to: :upgoing, guard: :upgoing_needed?
    end
    event :on do
      transitions from: :upgoing, to: :ongoing, guard: :ongoing_needed?
    end
    event :success do
      transitions from: :ongoing, to: :success, guard: :success_needed?
    end
    event :failure do
      transitions from: :ongoing, to: :failure, guard: :failure_needed?
    end
  end
  def self.state
    Project.aasm.states_for_select
  end
  def upgoing_needed?
    name && content && short_content && image_data && purpose
  end
  def ongoing_needed?
    category_id && contributions.any?
  end
  def failure_needed?
    contributions_sum = contributions.sum(:amount_in_cents)
    percentage = (contributions_sum * 100).fdiv(purpose)
    percentage < 100
  end

  def succes_needed?
    contributions_sum = contributions.sum(:amount_in_cents)
    percentage = (contributions_sum * 100).fdiv(purpose)
    percentage >= 100
  end
end
