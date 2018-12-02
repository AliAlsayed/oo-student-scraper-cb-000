require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    #students: doc.css(".student-name")
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
p Scraper.scrape_index_page("./fixtures/student-site/index.html")
