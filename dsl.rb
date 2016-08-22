require 'httparty'
require 'uri'
require_relative 'rule'
require_relative 'rules_container'

class Dsl
	include HTTParty
	follow_redirects false
	MAX_REDIRECTS = 3

    attr_accessor :id, :rules

    def initialize(id, &block)
      @id = id
	  @rules = RulesContainer.new()
	  instance_eval &block
	end

	def get(url, options = {})
		request('GET', url, options)
	end

	def post(url, options = {})
		request('POST', url, options)
	end

	def follow_redirects(rule, method)
		redirects_count = 0
		input_url = rule.url
		result = []
		loop do
			case method
			when 'GET'
				response_value = self.class.get(input_url)
			when 'POST'
				response_value = self.class.post(input_url, body: rule.body)
			else
			end
			result << { url: input_url, status: response_value.code.to_s, redirects: redirects_count}
			input_url =	response_value.header['location']
			redirects_count +=1
			if input_url && input_url !~ URI::regexp
				uri = URI(rule.url)
				uri.path = input_url
				input_url = uri.to_s
			end
			break unless input_url || redirects_count > MAX_REDIRECTS
		end
		return result
	end

	def get_response_respond_with(data)
		data.last[:url]
	end

	def get_response_redirects_count(data)
		data.last[:redirects]
	end

	def validate_redirects(data, redirect_code)
		data.each do |url_data|
			return false if url_data[:status] != redirect_code.to_s
		end
		true
	end

	def request(method, url, options = {})
		puts "*"
		rule = Rule.new(url, options)
		@rules.add(rule)
		result_ok = true
		results = []
		begin
			results = follow_redirects(rule, method)

			if rule.redirect_url
				respond_url = get_response_respond_with(results)
				result = rule.redirect_url == respond_url
				result_ok &&= result
				rule.error_message += "not #{rule.redirect_url} redirect url, " if false == result
			end

			if rule.response_code
				result = validate_redirects(results[0..(results.size-2)], rule.response_code)
				result_ok &&= result
				rule.error_message += "not #{rule.response_code} response code, " if false == result
			end

			rule.error_message += "redirects count: #{get_response_redirects_count(results)}" unless result_ok

		rescue HTTParty::Error => e
	    	error = 'HttParty::Error '+ e.message
	    	rule.error_message = error
		rescue StandardError => e
			error = 'StandardError '+ e.message
			rule.error_message = error
		else
			#rule.error_message = "Condition doesn't match" if false == result_ok
		end
	end

	def display_results
		puts "---------------\nTests done: #{rules.count}"
		if rules.with_errors.any?
			puts "Errors: #{rules.with_errors.length}\n---------------"
			puts rules.with_errors
		else
			puts "All fine :)\n---------------"
		end
	end
end