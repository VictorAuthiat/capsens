class Project < ApplicationRecord
  include AASM
  include LandUploader::Attachment.new(:image)
  belongs_to :category
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, source: :user
  accepts_nested_attributes_for :counterparts, :allow_destroy => true
  validates :name, presence: true
  validates :purpose, presence: true
  validates :content, presence: true
  validates :image_data, presence: true
  scope :sort_by_reverse_name_asc, lambda { order("REVERSE(name) ASC") }
  scope :sort_by_reverse_name_desc, lambda { order("REVERSE(name) DESC") }
  scope :upgoing, -> { where aasm_state: :upgoing }
  scope :ongoing, -> { where aasm_state: :upgoing }
  scope :succeeded, -> { where aasm_state: :success }
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
    percentage < 100
  end

  def sum
    contributions.pluck(:amount_in_cents).sum
  end

  def succes_needed?
    percentage >= 100
  end

  def state_badge
    if aasm_state == 'success'
      'success'
    elsif aasm_state == 'failure'
      'failure'
    else
      'up'
    end
  end

  def percentage
    contribution_sum = (sum * 100).fdiv(purpose).round
    contribution_sum = 100 if contribution_sum > 100
    ProjectPercentage.new.call(project: self, contribution_sum: contribution_sum)
    contribution_sum
  end
end
