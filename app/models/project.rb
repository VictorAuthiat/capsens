class Project < ApplicationRecord
  include AASM
  include LandUploader::Attachment.new(:image)
  belongs_to :category
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  validates :name, presence: true
  aasm do
    state :draft, initial: true
    state :upgoing
    state :ongoing

    event :up do
      transitions from: :draft, to: :upgoing, guard: :upgoing_needed?
    end
    event :on do
      transitions from: :upgoing, to: :ongoing, guard: :ongoing_needed?
    end
  end
  def self.state
    Project.aasm.states_for_select
  end
  def upgoing_needed?
    name && content && short_content && image_data && purpose ? true : false
  end
  def ongoing_needed?
    category_id && contributions.any? ? true : false
  end
end
