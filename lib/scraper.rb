require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    #students: doc.css(".student-name")
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
Scraper.scrape_index_page("./fixtures/student-site/index.html")
