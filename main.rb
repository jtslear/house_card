require 'sinatra'
require './zillow_home'
require './distance_finder'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end


JOHN= "5313 Echo Ridge Road Raleigh, NC 27612"
WORK="8521 Six Forks Rd Raleigh, NC 27615"
CHIPOTLE_1="6102 Falls of Neuse Rdi Raleigh, NC 27609"
CHIPOTLE_2="6602 Glenwood Ave Raleigh, NC 27612"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    address = @home.address
    john = DistanceFinder.new(address, JOHN)
    work = DistanceFinder.new(address, WORK)
    chipotle_1 = DistanceFinder.new(address, CHIPOTLE_1)
    chipotle_2 = DistanceFinder.new(address, CHIPOTLE_2)
    @john_time = john.time
    @work_time = work.time
    @chipotle_1_time = chipotle_1.time
    @chipotle_2_time = chipotle_2.time
  end

  herb :index
end
