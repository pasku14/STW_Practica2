require 'twitter'
require './configure'
require 'rack'
require 'thin'
require 'erb'

class Ver_Tweets


	def initialize 
		@tweets = []
		@usuario = ''
		@n_tweets = 0
	end


	def erb(template)
		template_file = File.open("Ver_Tweets.html.erb", 'r')
		ERB.new(File.read(template_file)).result(binding)
	end


	def call env
		req = Rack::Request.new(env)
		@tweets = []
		binding.pry if ARGV[0]
		@usuario = (req["user"] && req["user"] != '' && Twitter.user?(req["user"]) == true) ? req["user"] : ''
 		@n_tweets = (req["n_tw"] && req["n_tw"].to_i > 1) ? req["n_tw"].to_i : 1
		puts "#{@usuario}"

		if @usuario == req["user"]
			puts "#{@tweets}"
			tweet = Twitter.user_timeline(@usuario, {:count => @n_tweets.to_i})
			@tweets = (@tweets && @tweets != '') ? tweet.map{|i| i.text} : ''
		end

		Rack::Response.new(erb('Ver_Tweets.html.erb'))
		
	end
end

if $0 == __FILE__

	Rack::Server.start(
  		:app => Ver_Tweets.new,
  		:Port => 9999,
  		:server => 'thin'
	)
end
