require 'httparty'

$datas = []

class ABC
	include HTTParty

	CODES_TO_OBJ = ::Net::HTTPResponse::CODE_CLASS_TO_OBJ.merge ::Net::HTTPResponse::CODE_TO_OBJ
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
		result_ok = true
		begin
			case method
			when 'GET'
				response = self.class.get(url[:url])
				result_ok &&= url[:respond_with] == response.code if url[:respond_with]
				result_ok &&= url[:respond_to] == response.request.last_uri.to_s if url[:respond_to] && response.request.last_uri
				puts "Response: #{response.code} #{CODES_TO_OBJ[response.code.to_s]}"
				puts result_ok
			when 'POST'
				response = self.class.post(url[:url])
				result_ok &&= url[:respond_with] == response.code if url[:respond_with]
				puts result_ok
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
	get 'http://getbadg.es', :respond => :permanent_redirect, :respond_to => 'https://getbadges.io/'
	#get 'https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
	#post 'https://getbadges.io', :body => {content: 3}, :respond_with => 200
end
