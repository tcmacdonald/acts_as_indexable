FactoryGirl.define do

  factory :widget do
    sequence(:title){|n| "Widget ##{n}" }
    sequence(:body){|n| "Body ##{n}" }
  end

end
