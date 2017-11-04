FactoryBot.define do
  factory :movie do
    title       { Faker::Movie.quote }
    price_code  { [Movie::REGULAR, Movie::NEW_RELEASE, Movie::CHILDREN].sample }

    initialize_with { new(title, price_code) }

    trait :regular do
      price_code { Movie::REGULAR }
    end

    trait :new_release do
      price_code { Movie::NEW_RELEASE }
    end

    trait :children do
      price_code { Movie::CHILDREN }
    end
  end
end



