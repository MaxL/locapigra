require 'faker'

FactoryBot.define do
  factory :product do
    name { Faker::Book.title }
    description { Faker::FamousLastWords.last_words }
    meta_title { Faker::FamousLastWords.last_words }
    meta_description { Faker::FamousLastWords.last_words }
  end
end
