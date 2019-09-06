FactoryBot.define do
  factory :project do
    name { Faker::Food.dish }
    content { Faker::Food.description }
    short_content { Faker::Food.measurement }
    land_picture { 'land_picture' }
    thumb_picture { 'thumb_picture' }
    purpose { rand(10_000...100_000) }
    category_id { rand(1..Category.count)}
  end
end
