require 'sinatra'
require './zillow_home'

Tilt.register Tilt::ERBTemplate, 'html.erb'

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end

get '/' do
  if params[:site]
    @home = ZillowHome.new(params[:site])
  end

  herb :index
end
