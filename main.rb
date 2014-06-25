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
WHOLE_FOODS="8710 Six Forks Rdi Raleigh, NC 27615"
JOANN="4412 Falls of Neuse Rd Raleigh, NC 27609"
PETCO_1="6231 Triangle Plantation Dr Raleigh, NC 27616"
PETCO_2="7811 Alexander Promenade Pl Raleigh, NC 27617"
UNLEASHED="7414 Creedmoor Rd Raleigh, NC 27613"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    address = @home.address
    john = DistanceFinder.new(address, JOHN)
    work = DistanceFinder.new(address, WORK)
    chipotle_1 = DistanceFinder.new(address, CHIPOTLE_1)
    chipotle_2 = DistanceFinder.new(address, CHIPOTLE_2)
    whole_foods = DistanceFinder.new(address, WHOLE_FOODS)
    joann = DistanceFinder.new(address, JOANN)
    petco_1 = DistanceFinder.new(address, PETCO_1)
    petco_2 = DistanceFinder.new(address, PETCO_2)
    unleashed = DistanceFinder.new(address, UNLEASHED)
    @john_time = john.time
    @work_time = work.time
    @chipotle_1_time = chipotle_1.time
    @chipotle_2_time = chipotle_2.time
    @whole_foods_time = whole_foods.time
    @joann_time = joann.time
    @petco_1_time = petco_1.time
    @petco_2_time = petco_2.time
    @unleashed_time = unleashed.time
  end

  herb :index
end
