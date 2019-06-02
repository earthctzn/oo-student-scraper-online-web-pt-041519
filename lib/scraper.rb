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
    profile_array = doc.css(".social-icon-container")
    vitals = doc.css(".vitals-text-container")
    #binding.pry
    {
      blog: profile_array.css("a")[3]["href"],
      github: profile_array.css("a")[2]["href"],
      linkedin: profile_array.css("a")[1]["href"],
      profile_quote: vitals.css(".profile-quote").text,
      twitter: profile_array.css("a")[0]["href"],
      bio: doc.css(".description-holder p").text

    }
  end

end
