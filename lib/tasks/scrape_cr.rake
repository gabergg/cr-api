require 'nokogiri'
require 'open-uri'

namespace :db do
  desc "TODO"
  task populate: :environment do
    grab_coffees
  end
end


def grab_coffees

  base_url = "http://www.coffeereview.com/review/page/"

  page_count = 1
  json_return = []

  page = Nokogiri::HTML(open(base_url + page_count.to_s))

  while true

    page.css("div.review").each { |review|
      bean = {}

      bean[:name] = review.css("h2").css("a").text
      bean[:overall_rating] = review.css("div.review-rating").text.to_i
      bean[:roaster] = review.css("h3").css("a").text
      bean[:review_date] = Date.parse(review.css("div.review-col2").css("p")[0].text.split(': ')[1])
      bean[:description] = review.css("div.excerpt").css("p").text.split('Complete Rev')[0]

      Bean.where(name: bean[:name], overall_rating: bean[:overall_rating], roaster: bean[:roaster],
                 review_date: bean[:review_date], description: bean[:description]).first_or_create
    }

    begin
      page_count = page_count + 1
      page = Nokogiri::HTML(open(base_url + page_count.to_s))
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        break
      else
        raise e
      end
    end


  end

end