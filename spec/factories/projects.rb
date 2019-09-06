FactoryBot.define do
  factory :project do
    name { Faker::Food.dish }
    content { Faker::Food.description }
    short_content { Faker::Food.measurement }
    land_picture { File.open(Dir[Rails.root.join('lib/sample_images/projects/land_pictures/*')].sample) }
    thumb_picture { File.open(Dir[Rails.root.join('lib/sample_images/projects/thumb_pictures/*')].sample) }
    purpose { rand(10_000...100_000) }
    category_id { rand(1..Category.count)}
  end
end
