require 'nokogiri'
require 'open-uri'

class ZillowHome
  attr_reader :site, :page

  def initialize(site)
    @site = site
    @page = Nokogiri::HTML(open(@site))
  end


  def facts
    @facts ||= find_facts.map do |fact|
      {
        label: fact.children[0].text,
        value: fact.children[1].text
      }
    end
  end

  def formatted_facts
    facts.map {|fact| format_fact(fact)}
  end

  def rent
    page.css(".prop-value-price .value").text
  end

  def short_address
    address.split(",")[0]
  end

  def address
   page.css(".prop-addr").text
  end

  def find_facts
    @fact_elements ||= page.css("div.prop-facts li")
  end

  def format_fact(fact)
    "#{fact[:label]} #{fact[:value]}"
  end
end
