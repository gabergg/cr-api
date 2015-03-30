require 'spec_helper'

describe "Coffee Review API" do

  describe "Basic functionality" do

    it 'gets a set of reviews' do

      create_list(:bean, 10)

      get '/v2/reviews'

      expect(response).to be_success # test for 200 status code
      expect(json['reviews'].length).to eq(10) # check correct number of reviews

    end

    it 'gets a set of reviews with parameters' do

      create(:bean, location: :Andorra, roast: :light, roaster: :Victrola, origin: :Ethiopia, overall_rating: 95)
      create(:bean, location: :Guam, roast: :medium, roaster: :Heart, origin: :Guatemala, overall_rating: 80)
      create(:bean, location: :Andorra, roast: :light, roaster: :Victrola, origin: :Ethiopia, overall_rating: 81)
      create(:bean, location: :Andorra, roast: :medium, roaster: :Heart, origin: :Kenya, overall_rating: 60)
      create(:bean, location: :Andorra, roast: :light, roaster: :Heart, origin: :Ethiopia, overall_rating: 81)

      get '/v2/reviews?location=ando&roast=light&rating=82&count=5&roaster=vic&order=rating'

      expect(response).to be_success
      expect(json['reviews'].length).to eq(1)

    end

  end

  describe "Limit by certain attributes" do

    before {
      create(:bean, location: :Andorra, roast: :light, roaster: :Victrola, origin: :Ethiopia, overall_rating: 95)
      create(:bean, location: :Guam, roast: :medium, roaster: :Heart, origin: :Guatemala, overall_rating: 80)
      create(:bean, location: :Andorra, roast: :light, roaster: :Heart, origin: :Ethiopia, overall_rating: 81)
    }

    it 'gets reviews with certain location' do

      get '/v2/reviews?location=ando' # lowercase, substring front

      expect(response).to be_success
      json['reviews'].each do |review|
        expect(review['location']).to eq("Andorra") # check proper location
      end

    end

    it 'gets reviews with certain roast' do

      get '/v2/reviews?roast=light'

      expect(response).to be_success
      json['reviews'].each do |review|
        expect(review['roast']).to eq("light") # check proper roast level
      end

    end

    it 'gets reviews with certain roaster' do

      get '/v2/reviews?roaster=heart'

      expect(response).to be_success
      json['reviews'].each do |review|
        expect(review['roaster']).to eq("Heart") # check proper roaster
      end

    end

    it 'gets reviews with certain origin' do

      get '/v2/reviews?origin=pia' # substring back

      expect(response).to be_success
      json['reviews'].each do |review|
        expect(review['origin']).to eq("Ethiopia") # check proper origin
      end

    end

    it 'gets reviews with certain rating or higher' do

      get '/v2/reviews?rating=81'

      expect(response).to be_success
      json['reviews'].each do |review|
        expect(review['overall_rating']).to be >= 81 # check proper rating
      end

    end

  end

  describe "Limiting number of reviews returned" do

    before {
      create_list(:bean, 105)
    }

    it 'gets only 100 reviews when no count specified' do

      get '/v2/reviews'

      expect(response).to be_success
      expect(json['reviews'].length).to eq(100) # check default count of 100

    end

    it 'gets certain number of reviews' do

      get '/v2/reviews?count=50'

      expect(response).to be_success
      expect(json['reviews'].length).to eq(50) # check proper count

    end

  end

  describe "Ordering returned reviews" do

    before {
      create(:bean, location: :Philadelphia, roast: :light, roaster: :Victrola, origin: :Kenya, overall_rating: 95)
      create(:bean, location: :Saline, roast: :dark, roaster: :Andytown, origin: :Guatemala, overall_rating: 80)
      create(:bean, location: :Hanoi, roast: :medium, roaster: :Heart, origin: :Ethiopia, overall_rating: 81)
    }

    it 'gets reviews ordered by ascending attribute' do

      ordersAsc = ['location', 'origin', 'roaster']

      ordersAsc.each do |order| # orders that sort by ascending (location, origin, roaster)

        get '/v2/reviews?order='+order

        json = JSON.parse(response.body)

        expect(response).to be_success
        expect(json['reviews'] == json['reviews'].sort_by { |review| review[order] }).to be true # check order

      end
    end

    it 'gets reviews ordered by descending rating' do

      get '/v2/reviews?order=rating'

      expect(response).to be_success
      expect(json['reviews'] == json['reviews'].sort_by { |review| review['overall_rating'] }.reverse).to be true # check order

    end

    it 'gets reviews ordered by created_at by default' do

      get '/v2/reviews'

      expect(response).to be_success
      expect(json['reviews'] == json['reviews'].sort_by { |review| review['created_at'] }).to be true # check order

    end

  end

end