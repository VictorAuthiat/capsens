FactoryBot.define do
  factory :contribution do
    user { nil }
    project { nil }
    counterpart { nil }
    amount_in_cents { 1 }
  end
end
