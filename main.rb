require 'sinatra'
require './zillow_home'
require './distance_finder'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end


MIRANDA_WORK = "109 Ridge St, Knightdale, NC 27545"
JASON_WORK = "213 Fayetville St, Raleigh, NC 27601"
CHURCH = "3500 Spring Forest Rd, Raleigh, NC 27616"

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
    address = @home.address
    mirandas_work_finder = DistanceFinder.new(address, MIRANDA_WORK)
    jasons_work_finder = DistanceFinder.new(address, JASON_WORK)
    church_finder = DistanceFinder.new(address, CHURCH)
    @miranda_time = mirandas_work_finder.time
    @jason_time = jasons_work_finder.time
    @church_time = church_finder.time
  end

  herb :index
end
