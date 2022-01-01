class Turkey
  require 'nokogiri'
  require 'open-uri'

  def parse_university
    doc = Nokogiri::HTML5.parse(open("./app/assets//html/turkey.html"))
    tables = doc.css('.table-striped')
    i = 0
    space = "---------------------------------------------------------"
    universities = Array.new
    cities = Array.new

    tables.xpath('//tbody//tr').each do |table|

      universities << table.css('td:nth-child(1)').text
      cities << table.css('td:nth-child(2)').text

      i += 1
    end

    cities.each do |t|
      data = ::City.find_by(name: t)
      if data.blank?
        ::City.create(country_id: 1, name: t).save
      end
    end

    universities.each_with_index do |u, index|
      city = ::City.find_by(name: cities[index])
      if !city.blank?
        University.create(city_id: city.id, name: u, country_id: 1).save
      end
    end

  end

end