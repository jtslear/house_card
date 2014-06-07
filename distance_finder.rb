require 'httparty'

class DistanceFinder
  attr_reader :origin, :destination

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def time
    direction_information["routes"][0]["legs"][0]["duration"]["text"]
  end

  private
  def direction_information
    @direction_information || lookup_information
  end

  def lookup_information
    url = URI.encode "http://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}"
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end
end
