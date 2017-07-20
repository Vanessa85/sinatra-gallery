require 'sinatra'
require 'sprockets'
require 'sinatra/reloader'
require 'active_record'
require_relative 'helpers'

Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each{ |model| require model }

configure do
  enable :reloader
  set :environment, Sprockets::Environment.new
  settings.environment.append_path 'assets/stylesheets'
  settings.environment.append_path 'assets/javascripts'
  settings.environment.append_path 'vendor'
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'dbdemo.sqlite3'
)

get '/assets/*' do
  env['PATH_INFO'].sub!('/assets', '')
  settings.environment.call(env)
end

get '/' do
  @images = Image.all
  render_view 'images/index'
end

get '/images/new/?' do
  render_view 'images/new'
end

post '/images/new' do
  
  redirect '/'
end
