require 'sinatra'
require './zillow_home'
require './distance_finder'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end


RWORK="2810 Meridian Parkway #176, Durham, NC 27713"
JWORK="1101 Haynes St #105, Raleigh, NC 27604"
MWORK="160 Pharma Dr, Morrisville, NC 27560"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    @address = @home.address
  else
    @address = params[:address]
  end

  if @address
    address = @address
    rwork = DistanceFinder.new(address, RWORK)
    jwork = DistanceFinder.new(address, JWORK)
    mwork = DistanceFinder.new(address, MWORK)
    @rwork_time = rwork.time
    @jwork_time = jwork.time
    @mwork_time = mwork.time
  end

  herb :index
end
