FactoryBot.define do
  factory :rental do
    movie       { build(:movie) }
    days_rented { (1..10).to_a.sample }

    initialize_with { new(movie, days_rented) }

    trait :regular do
      movie { build(:movie, :regular) }
    end

    trait :new_release do
      movie { build(:movie, :new_release) }
    end

    trait :children do
      movie { build(:movie, :children) }
    end
  end
end
