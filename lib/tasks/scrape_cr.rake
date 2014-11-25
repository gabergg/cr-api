require 'nokogiri'
require 'open-uri'
require 'mechanize'

namespace :db do
  desc "TODO"
  task populate: :environment do
    grab_coffees
  end
end


def grab_coffees

  agent = Mechanize.new

  base_url = "http://www.coffeereview.com/review/page/"

  page_count = 1
  @json_return = []

  page = agent.get(base_url + @page_count.to_s)

  while true
    
    if page_count > 1
      break
    end

    bean_links = page.links.find_all { |l| l.attributes.parent.name == 'h2' }
    bean_links.shift

    #follow each link into its bean
    bean_links.each do |link|
      bean_page = link.click
      doc = bean_page.parser

      @bean = {}

      @bean[:name] = doc.css("h2").css("a").text
      @bean[:overall_rating] = doc.css("div.review-rating").text.to_i
      @bean[:roaster] = doc.css("h3").css("a").text
      
      bean_info = doc.css("div.review-content").css("p")
      @bean[:location] = bean_stats[0].text.split(': ')[1]
      @bean[:origin] = bean_stats[1].text.split(': ')[1]
      @bean[:roast] = bean_stats[2].text.split(': ')[1]
      @bean[:price] = bean_stats[3].text.split(': ')[1]

      pcounter = 0
      espresso = true
      bean_stats = doc.css("div.review-col2").css("p")
      @bean[:review_date] = bean_stats[pcounter].text.split(': ')[1]
      pcounter += 1
      @bean[:agtron] = bean_stats[pcounter].text.split(': ')[1].to_i
      pcounter += 1
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
      @bean[:flavor] = bean_stats[pcounter].text.split(': ')[1].to_i
      pcounter += 1
      @bean[:aftertaste] = bean_stats[pcounter].text.split(': ')[1].to_i
      pcounter += 1
      if bean_stats[pcounter].text.split(': ')[1].length >= 2
        @bean[:with_milk] = bean_stats[pcounter].text.split(': ')[1].to_i
        pcounter += 1
      end
      pcounter += 1
      @bean[:description] = bean_stats[pcounter].text

      Bean.where(name: @bean[:name], overall_rating: @bean[:overall_rating], roaster: @bean[:roaster],
                 review_date: @bean[:review_date], description: @bean[:description]).first_or_create
      
    end

    begin
      @page_count += 1
      @page = Nokogiri::HTML(open(base_url + @page_count.to_s))
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        break
      else
        raise e
      end
    end


  end

end