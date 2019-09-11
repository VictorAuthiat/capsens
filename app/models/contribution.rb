class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :counterpart
  validates :amount_in_cents, presence: true, inclusion: 100..10_000_000
end
