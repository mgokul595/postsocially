
FactoryGirl.define do
  factory :user do
    email "gokul@gmail.com"
    password "12345678"
  end

  factory :topic do
    name "Rails"
  end
end