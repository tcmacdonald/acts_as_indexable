FactoryGirl.define do

  factory :widget do
    sequence(:title){|n| "Widget ##{n}" }
    sequence(:email){|n| "person#{n}@somewhere.com" }
    sequence(:body){|n| "Body ##{n}" }
    price 12.5
  end

end
