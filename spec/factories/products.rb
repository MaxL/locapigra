require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Book.title }
    description { Faker::Lebowski.quote }
    meta_title { Faker::Book.title }
    meta_description { Faker::Lebowski.quote }
    cover_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/aik.jpg'), 'image/jpeg') }
    taxrate { Faker::Number.number(2) }
    weight { Faker::Number.between(1, 10) }
    quantity { Faker::Number.number(3) }
    package { Faker::Lebowski.character }
    language { Faker::Lebowski.character }
    sequence(:position) { |n| n}
  end
end
