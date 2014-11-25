class ApiController < ApplicationController

  def parse_params

    @count = params['count']
    @rating = params['rating']
    @order = params['order']
    @location = params['location']

    @count ||= 300
    @rating ||= 50

    case @order
      when "location"
        @order_string = 'location ASC'
      when "origin"
        @order_string = 'origin ASC'
      when "rating"
        @order_string = 'overall_rating DESC'
      when "roast"
        @order_string = 'roast DESC'
      when "roaster"
        @order_string = 'roaster ASC'
      else
        @order_string = 'review_date DESC'
    end

    json_result = grab_by_term

    render :json => json_result, :status => :ok

  end

  def grab_by_term

    json_return = {}
    if @location
      json_return[:reviews] = Bean.where("overall_rating >= ? AND location like ?", @rating, "%#{@location}%").limit(@count).reorder(@order_string)
    else
      json_return[:reviews] = Bean.where("overall_rating >= ?", @rating).limit(@count).reorder(@order_string)
    end

    return json_return.to_json

  end

end
