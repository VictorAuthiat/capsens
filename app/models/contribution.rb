class Contribution < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :project
  belongs_to :counterpart
  validates :amount_in_cents, presence: true, inclusion: 100..10_000_000
  aasm do
    state :created, initial: true
    state :payment_pending
    state :paid

    event :initialize_payment do
      transitions from: :create, to: :payment_pending
    end

    event :pay do
      transitions from: :payment_pending, to: :paid
    end
  end
end
