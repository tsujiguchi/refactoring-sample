FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }

    initialize_with { new(name) }
  end
end
