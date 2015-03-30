FactoryGirl.define do
  
  factory :bean do
    sequence(:name) { |n| "Bean #{n}" }
    sequence(:roaster) { |n| "Roaster #{n/2}" }
    roast { [:light, :medium, :dark].sample }
    overall_rating { rand(60..99) }
    review_date { Time.at(rand*Time.now.to_i) }
    sequence(:description) { |n| "Description #{n}" }
    location { [:California, :Michigan, :Florida].sample }
    origin { [:Guatemala, :Ethiopia, :Indonesia].sample }
  end

end