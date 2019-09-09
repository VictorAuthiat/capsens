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
      transitions from: :draft, to: :upgoing, if: :upgoing_needed?
    end
    event :upgoing_if_needed do
      transitions from: :draft, to: :upgoing do
        guard do
          upgoing_needed?
        end
      end
      transitions from: :draft, to: :upgoing
    end
    event :on do
      transitions from: :upgoing, to: :ongoing, if: :ongoing_needed?
    end
    event :ongoing_if_needed do
      transitions from: :upgoing, to: :ongoing do
        guard do
          ongoing_needed?
        end
      end
      transitions from: :upgoing, to: :ongoing
    end
    event :failure do
    end
    event :success do
    end
  end

  def upgoing_needed?
    self.name && self.content && self.short_content && self.image_data ? true : false
  end
  def ongoing_needed?
    self.category_id && self.contributions.any? ? true : false
  end
end
