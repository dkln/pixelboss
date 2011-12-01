require 'rubygems'

require 'sinatra'
require 'coffee-script'
require 'haml'
require 'sass'
require 'compass'

require './lib/pixel_map'

PixelMap.setup!

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))

  set :haml, { format: :html5 }
  set :sass, Compass.sass_engine_options
end

get '/' do
  haml :app, locals: { rows: PixelMap.rows }
end

get '/place-pixel' do
  PixelMap.write!(params[:pos].to_i, params[:color].to_i)
end

get '/app.js' do
  coffee :app
end

get '/app.css' do
  content_type 'text/css', charset: 'utf-8'
  sass :app
end
