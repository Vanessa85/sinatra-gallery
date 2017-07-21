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
  image_file = params[:image_file]
  unless image_file.empty?
    uploads_path = File.join(settings.public_folder, 'uploads')
    Dir.mkdir(uploads_path) unless Dir.exist?(uploads_path)
    File.open(File.join(uploads_path, image_file[:filename]), 'wb') do |file|
      file.write(image_file[:tempfile].read)
    end

    @image = Image.new(
      :title => params[:image][:title],
      :filename => image_file[:filename],
      :size => image_file[:tempfile].size.to_f/1024) #kb

    if @image.save
      redirect '/'
    end
  end
end
