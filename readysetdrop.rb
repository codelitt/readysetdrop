require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require 'sinatra/assetpack'
require 'erb'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  Less.paths << "#{App.root}/app/css"

  register Sinatra::AssetPack

  assets do

    js :main, '/js/main.js', [
      '/js/vendor/jquery*.js',
      '/js/vendor/bootstrap*.js'
    ]
    
    js :scroll, '/js/scroll.js', [
    	'/js/scroll*.js'
    ]

    css :bootstrap, [
      '/css/theme.css',
      '/css/responsive.css'
    ]

    prebuild true

  end

  get '/' do
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end