FactoryBot.define do
  factory :category do
    name { Faker::Creature::Animal.name }
  end
end
