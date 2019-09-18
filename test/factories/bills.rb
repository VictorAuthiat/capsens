FactoryBot.define do
  factory :bill do
    user { nil }
    contribution { nil }
    project { nil }
    content { "MyText" }
    name { "MyString" }
  end
end
