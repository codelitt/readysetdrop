require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require 'sinatra/assetpack'
require 'erb'
require 'uglifier'
require 'nokogiri'
require 'open-uri'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  Less.paths << "#{App.root}/app/css"

  register Sinatra::AssetPack
# '/js/vendor/bootstrap*.js'
  assets do
  
	  serve '/images', from: 'app/images'

    js :main, '/js/main.js', [
      '/js/vendor/jquery*.js'
    ]

		js :appscroll, '/js/appscroll.js', [
			'/js/scroll.js'
		]

    css :bootstrap, [
      '/css/theme.css',
      '/css/responsive.css'
    ]
    
    js_compression :uglify 

    prebuild true

  end

  get '/' do
  	
  	#load url to be scraped and parsed
  	url = "http://www.causes.com/causes/791631-ready-set-drop/actions/1681438?utm_campaign=home"
  	
  	#pushes url data into Nokogiri to be parsed and sets object "data" as this url content
  	data = Nokogiri::HTML(open(url))
	
		#create instance variable for span class "count" to be referenced in view
		@count = data.css('.count')
		@percent = data.css('.count')
		@number = data.css('.count')
  	
  	# renders ERB template 
    erb :index
  end
  
  not_found do
  	redirect '404.html'
	end

  # start the server if ruby file executed directly
  run! if app_file == $0
end