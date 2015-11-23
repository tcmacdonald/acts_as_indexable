FactoryGirl.define do

  factory :widget do
    sequence(:title){|n| "Widget ##{n}" }
    body 'Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.'
  end

end
