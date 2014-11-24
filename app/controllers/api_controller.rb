class ApiController < ApplicationController

  def parse_params

    @count = params['count']
    @rating = params['rating']
    @order = params['order']
    #@location = params['location']

    @count ||= 100

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

    json_return[:reviews] = Bean.where("overall_rating >= ?",
                                       @rating).select(:name, :roaster, :overall_rating, :review_date,
                                                       :description).limit(@count).reorder(@order_string)

    return json_return.to_json

  end

end
