require 'sinatra'
require './zillow_home'
require './distance_finder'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end


JOHN= "5313 Echo Ridge Road Raleigh, NC 27612"
RWORK="2810 Meridian Parkway #176, Durham, NC 27713"
EWORK="434 Fayetteville St #1120, Raleigh, NC 27601"
PETCO_1="6231 Triangle Plantation Dr Raleigh, NC 27616"
PETCO_2="7811 Alexander Promenade Pl Raleigh, NC 27617"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    @address = @home.address
  else
    @address = params[:address]
  end

  if @address
    address = @address
    john = DistanceFinder.new(address, JOHN)
    rwork = DistanceFinder.new(address, RWORK)
    ework = DistanceFinder.new(address, EWORK)
    petco_1 = DistanceFinder.new(address, PETCO_1)
    petco_2 = DistanceFinder.new(address, PETCO_2)
    @john_time = john.time
    @rwork_time = rwork.time
    @ework_time = ework.time
    @petco_1_time = petco_1.time
    @petco_2_time = petco_2.time
  end

  herb :index
end
