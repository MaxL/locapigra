FactoryBot.define do
  factory :subscriber do
    name { "MyString" }
    email { "MyString" }
    confirmed { false }
    confirmation_token { "MyString" }
  end
end
