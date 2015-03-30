require 'spec_helper'

describe "Coffee Review API" do
  it 'gets a set of bean reviews' do
    create_list(:bean, 10)

    get '/v2/reviews'

    expect(response).to be_success            # test for the 200 status-code
    expect(json['reviews'].length).to eq(10) # check to make sure the right amount of messages are returned
  end
  
  it 'gets beans with matching location' do

    create(:bean, location: :Andorra)
    create(:bean, location: :Guam)
    create(:bean, location: :Andorra)

    get '/v2/reviews?location=ando'

    expect(response).to be_success            # test for the 200 status-code
    json['reviews'].each do |review|
      expect(review['location']).to eq("Andorra")
    end
    
  end
  
  it 'gets beans with matching roast' do
    
  end

  it 'gets beans with matching roaster' do

  end

  it 'gets beans with matching origin' do

  end

  it 'gets beans with certain rating or higher' do

  end

  it 'gets certain number of beans' do

  end

  it 'gets beans ordered by rating' do

  end
  
  it 'gets beans ordered by roaster' do

  end
  
  it 'gets beans ordered by roast' do

  end
  
  it 'gets beans ordered by origin' do

  end
  
  it 'gets beans ordered by location' do

  end
  
  it 'gets beans ordered by date' do

  end

end