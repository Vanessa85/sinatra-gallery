require 'sinatra'
require 'sprockets'
require 'sinatra/reloader'
require_relative 'helpers'

configure do
  enable :reloader
  set :environment, Sprockets::Environment.new
  settings.environment.append_path 'assets/stylesheets'
  settings.environment.append_path 'assets/javascripts'
end

get '/assets/*' do
  env['PATH_INFO'].sub!('/assets', '')
  settings.environment.call(env)
end

get '/' do
  "Hello world"
end

get '/images/new/?' do
  render_view 'images/new'
end
