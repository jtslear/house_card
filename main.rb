require 'sinatra'
require './zillow_home'
require './distance_finder'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end


JOHN= "5313 Echo Ridge Road Raleigh, NC 27612"
WORK="8521 Six Forks Rd Raleigh, NC 27615"
WHOLE_FOODS="8710 Six Forks Rdi Raleigh, NC 27615"
JOANN="4412 Falls of Neuse Rd Raleigh, NC 27609"
PETCO_1="6231 Triangle Plantation Dr Raleigh, NC 27616"
PETCO_2="7811 Alexander Promenade Pl Raleigh, NC 27617"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    address = @home.address
    john = DistanceFinder.new(address, JOHN)
    work = DistanceFinder.new(address, WORK)
    whole_foods = DistanceFinder.new(address, WHOLE_FOODS)
    joann = DistanceFinder.new(address, JOANN)
    petco_1 = DistanceFinder.new(address, PETCO_1)
    petco_2 = DistanceFinder.new(address, PETCO_2)
    @john_time = john.time
    @work_time = work.time
    @whole_foods_time = whole_foods.time
    @joann_time = joann.time
    @petco_1_time = petco_1.time
    @petco_2_time = petco_2.time
  end

  herb :index
end
