require 'httparty'

$datas = []

class ABC
	include HTTParty
	follow_redirects false
	MAX_REDIRECTS = 3

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

	def follow_redirects(url)
		redirects_count = 0
		input_url = url
		result = []
		loop do
			response = self.class.get(input_url)
			result << { url: input_url, status: response.code.to_s, redirects: redirects_count}
			input_url =	response.header['location']
			redirects_count +=1
			break unless input_url || redirects_count > MAX_REDIRECTS
		end
		return result
	end

	def get_response_respond_with(data)
		data.last[:url]
	end

	def get_response_status_code(data)
		data.last[:status]
	end

	def get_response_redirects_count(data)
		data.last[:redirects]
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
				results = follow_redirects(url[:url])
				status_code = get_response_status_code(results)
				respond_url = get_response_respond_with(results)
				result_ok &&= url[:respond_with] == status_code if url[:respond_with]
				result_ok &&= url[:respond_to] == respond_url if url[:respond_to]
				puts "For #{url[:url]} response code is #{status_code} #{CODES_TO_OBJ[status_code]} and redirects: #{get_response_redirects_count(results)}"
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
	get 'https://getbadges.io/image.svg', :have_mime_type => 'image/svg'
	#post 'https://getbadges.io', :body => {content: 3}, :respond_with => 200
end
