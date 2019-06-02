require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = doc.css(".student-card")
    student_array.map do |div|
      {
        location: div.css("p.student-location").text,
        name: div.css("h4.student-name").text,
        profile_url: div.css("a").first["href"]
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    vitals = doc.css(".vitals-text-container")
    profile_array = doc.css("div.social-icon-container a")
    student_info = {}
    profile_array.each do |link|
      href = link.attr("href")
      if href.include?("github")
        student_info[:github] = href
      elsif href.include?("linkedin")
        student_info[:linkedin] = href
      elsif href.include?("twitter")
        student_info[:twitter] = href
      elsif href.include?("instagram")
        student_info[:blog] = href
      elsif href.include?("facebook")
        student_info[:blog] = href
      elsif href.include?("http")
        student_info[:blog] = href
      end
    end
#binding.pry
    student_info[:profile_quote] = vitals.css(".profile-quote").text
    student_info[:bio] = doc.css(".description-holder p").text

    student_info
  end

end
