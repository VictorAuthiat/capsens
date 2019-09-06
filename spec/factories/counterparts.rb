FactoryBot.define do
  factory :counterpart do
    project
    amount_in_cents { rand(5000...10_000) }
  end
end
