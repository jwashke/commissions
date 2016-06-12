FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password "password"

    factory :signed_user do
      signed_docs true
    end
  end
end
