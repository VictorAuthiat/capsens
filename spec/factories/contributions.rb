FactoryBot.define do
  factory :contribution do
    amount_in_cents { rand(5000..10_000) }
    project
    counterpart
    user
  end
end
