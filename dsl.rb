require 'httparty'
require 'uri'
require_relative 'rule'
require_relative 'rules_container'
require_relative 'mailer'

$stdout.sync = true

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
		input_url = URI.encode(rule.url)
		result = []
		loop do
			case method
			when 'GET'
				response_value = self.class.get(input_url)
			when 'POST'
				response_value = self.class.post(input_url, body: rule.body)
			else
			end
			result << {
				url: input_url,
				status: response_value.code.to_s,
				redirects: redirects_count,
				content_type: response_value.header['content-type']
			}

			input_url =	response_value.header['location'] ? URI.encode(response_value.header['location']) : nil
			redirects_count +=1
			if input_url && input_url !~ URI::regexp
				uri = URI(rule.url)
				uri.path = input_url
				input_url = uri.to_s
			end
			break unless (input_url && redirects_count < MAX_REDIRECTS)
		end
		result
	end

	def get_response_respond_with(data)
		data.last[:url]
	end

	def get_content_type(data)
		data.last[:content_type]
	end

	def get_response_redirects_count(data)
		data.last[:redirects]
	end

	def validate_redirects(data, redirect_code)
		data.each do |url_data|
			return url_data[:status] if url_data[:status] != redirect_code.to_s
		end
		true
	end

	def request(method, url, options = {})
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
				rule.error_message += "the final destination is #{respond_url}, " if false == result
			end

			if rule.response_code
				valid_or_code = validate_redirects(results[0..(results.size-2)], rule.response_code)
				result_ok &&= true === valid_or_code
				rule.error_message += "response code is #{valid_or_code}, " unless true === valid_or_code
			end

			if rule.content_type
				content_type = get_content_type(results)
				result = rule.content_type == content_type
				result_ok &&= result
				rule.error_message += "#{content_type} content type, " if false == result
			end

			rule.error_message += "redirects count: #{get_response_redirects_count(results)}" unless result_ok

		rescue HTTParty::Error => e
	    	error = 'HttParty::Error '+ e.message
	    	rule.error_message = error
	    	result_ok = false
		rescue StandardError => e
			error = 'StandardError '+ e.message
			rule.error_message = error
		    result_ok = false
		end
		print result_ok ? "+" : "-"
	end

	def display_results
		puts "\n---------------\nTests done: #{rules.count}"
		if rules.with_errors.any?
			puts "Errors: #{rules.with_errors.length}\n---------------"
			puts rules.with_errors
		else
			puts "All fine :)\n---------------"
		end
		return self
	end

	def send_email
		if rules.with_errors.any?
			mailer = Mailer.new(rules.with_errors)
			mailer.send
		end
	end
end