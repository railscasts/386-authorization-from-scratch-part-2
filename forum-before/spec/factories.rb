FactoryGirl.define do
  factory :topic do
    name "Foo"
  end

  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "foobar"
  end
end
