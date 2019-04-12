require 'faker'

FactoryBot.define do
  sequence(:random_int) do |n|
    @random_int ||= (1..100).to_a.shuffle
    @random_int[n]
  end

  factory :comic do
    name { Faker::Book.title }
    description { Faker::FamousLastWords.last_words }
    pages { FactoryBot.generate(:random_int) }
    cover {'Softcover'}
    color {'full colors'}
    dimensions {'A4'}
    sequence(:position) { |n| n}
  end
end
