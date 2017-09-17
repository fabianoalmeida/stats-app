FactoryGirl.define do
  factory :query do
    trait :regular do
      sentence 'This is a sentence'
      rating 0
    end

    trait :without_sentence do
      sentence nil
      rating 0
    end

    trait :without_rating do
      sentence 'Without rating'
      rating nil
    end
  end
end
