require 'sinatra'
require 'sprockets'
require 'sinatra/reloader'
require 'active_record'
require_relative 'helpers'

Dir[File.join(File.dirname(__FILE__), 'models', '*.rb')].each{ |model| require model }

configure do
  enable :reloader
  set :port, 3000
  set :environment, Sprockets::Environment.new
  settings.environment.append_path 'assets/stylesheets'
  settings.environment.append_path 'assets/javascripts'
  settings.environment.append_path 'vendor'
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/dbdemo.sqlite3'
)

after do
  ActiveRecord::Base.clear_active_connections!
end

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
  image_file = params[:image_file]

  @image = Image.new(
    :title => params[:image][:title],
    :filename => image_file[:filename],
    :size => image_file[:tempfile].size.to_f/1024) #kb

  if @image.save_with_file(image_file)
    redirect '/'
  end

end
