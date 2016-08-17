require 'httparty'

$datas = []

class ABC
	include HTTParty

    attr_accessor :id, :urls

    def initialize(id, &block)
      self.id = id
	  self.urls = []
	  instance_eval &block
	end

	def get(url, options = {})
		request('GET', url, options)
	end

	def post(url, options = {})
		request('POST', url, options)
	end

	def request(method, url, options = {})
		url = {:url => url}
		options.each do |option|
		  	url[option.first] = option.last
		end
		urls << url
		begin
			case method
			when 'GET'
				response = self.class.get(url[:url])
			when 'POST'
			else
			end
			rescue HTTParty::Error => e
	    		puts 'HttParty::Error '+ e.message
			rescue StandardError => e
				puts 'StandardError '+ e.message
		end
	end

	def add(datas)
		datas << self
	end
end

ABC.new("getbadges") do
	get 'http://getbadges.io', :respond => :permanent_redirect, :respond_to => 'https://getbadges.io'
	get 'https://https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
	post 'https://getbadges.io', :body => {content: 3}, :respond_with => :ok
end
