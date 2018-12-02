require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = {}
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content").css(".description-holder p").text
    social = doc.css(".social-icon-container").css("a")
    social.each do |social|
      link = social.attribute("href").value
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile
    #binding.pry
  end

end
student = Scraper.scrape_index_page("./fixtures/student-site/index.html").first
p Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html")
