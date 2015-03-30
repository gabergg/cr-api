require 'nokogiri'
require 'open-uri'
require 'mechanize'

namespace :db do
  desc "TODO"
  task populate: :environment do
    grab_coffees(false) #scrape only reviews on site that aren't already in our database
  end

  task populateall: :environment do
    grab_coffees(true) #scrape all reviews on site
  end
end

def grab_coffees(all)

  agent = Mechanize.new

  base_url = "http://www.coffeereview.com/review/page/"

  @page_count = 1
  @json_return = []

  @page = agent.get(base_url + @page_count.to_s)

  while true

=begin
    #page limit if need be
    if @page_count > 39
      break
    end
=end


    bean_links = @page.links.find_all { |l| l.attributes.parent.name == 'h2' }

    #follow each link into its bean
    bean_links.each do |link|
      bean_page = link.click
      doc = bean_page.parser

      @bean = {}

      @bean[:name] = doc.css("div.review-col1").css("h2").text
      @bean[:roaster] = doc.css("div.review-col1").css("h3").text
      @bean[:overall_rating] = doc.css("div.review-rating").text.to_i

      bean_info = doc.css("div.review-col1").css("p")
      @bean[:location] = bean_info[0].text.split(': ')[1]
      @bean[:origin] = bean_info[1].text.split(': ')[1]
      @bean[:roast] = bean_info[2].text.split(': ')[1]
      @bean[:price] = bean_info[3].text.split(': ')[1]

      pcounter = 0
      espresso = true
      bean_stats = doc.css("div.review-col2").css("p")
      @bean[:review_date] = bean_stats[pcounter].text.split(': ')[1]
      pcounter += 1
      @bean[:agtron] = bean_stats[pcounter].text.split(': ')[1]
      pcounter += 1
      if bean_stats[pcounter]
        @bean[:aroma] = bean_stats[pcounter].text.split(': ')[1].to_i
        pcounter += 1
        acidityOrBody = bean_stats[pcounter].text.split(': ')[0]
        if acidityOrBody == "Acidity"
          @bean[:acidity] = bean_stats[pcounter].text.split(': ')[1].to_i
          espresso = false
          pcounter += 1
        end
        @bean[:body] = bean_stats[pcounter].text.split(': ')[1].to_i
        pcounter += 1
        if bean_stats[pcounter]
          @bean[:flavor] = bean_stats[pcounter].text.split(': ')[1].to_i
          pcounter += 1
          if bean_stats[pcounter]
            @bean[:aftertaste] = bean_stats[pcounter].text.split(': ')[1].to_i
            pcounter += 1
            if bean_stats[pcounter]
              if bean_stats[pcounter].text.split(': ')[1].length <= 2
                @bean[:with_milk] = bean_stats[pcounter].text.split(': ')[1].to_i
              end
            end
          end
        end
      end

      pInReview = doc.css("div.review-content").css("p").length
      @bean[:description] = doc.css("div.review-content").css("p")[pInReview-4].text
      p @bean[:overall_rating]

      #Bean.where(@bean).first_or_create

      this_bean = Bean.where(@bean)
      if this_bean && all == false
        return
      else
        this_bean.create
      end

    end

    begin
      @page_count += 1
      @page = agent.get(base_url + @page_count.to_s)
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        break
      else
        raise e
      end
    end


  end

end
