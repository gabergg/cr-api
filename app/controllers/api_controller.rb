class ApiController < ApplicationController

  def parse_params

    @count = params['count']
    @rating = params['rating']
    @order = params['order']
    @location = params['location']
    @origin = params['origin']
    @roast = params['roast']
    @roaster = params['roaster']

    @count ||= 100
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
        @order_string = 'created_at ASC'
    end

    json_result = grab_by_term

    render :json => json_result, :status => :ok

  end

  def grab_by_term

    json_return = {}
    sqlParams = {}
    sqlQuery = "overall_rating >= :rating"
    sqlParams[:rating] = @rating

    if @location
      sqlQuery += " AND lower(location) like :location"
      sqlParams[:location] = "%#{@location.downcase}%"
    end

    if @origin
      sqlQuery += " AND lower(origin) like :origin"
      sqlParams[:origin] = "%#{@origin.downcase}%"
    end

    if @roast
      sqlQuery += " AND lower(roast) like :roast"
      sqlParams[:roast] = "%#{@roast.downcase}%"
    end

    if @roaster
      sqlQuery += " AND lower(roaster) like :roaster"
      sqlParams[:roaster] = "%#{@roaster.downcase}%"
    end

    json_return[:reviews] = Bean.where(sqlQuery, sqlParams).limit(@count).reorder(@order_string).as_json.map do |bean|
      bean.except("id", "created_at", "updated_at")
    end

    return json_return.to_json

  end

end
