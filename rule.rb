class Rule
    attr_accessor :condition, :url, :options, :error_message

    def initialize(url, options)
	  @url = url
	  @options = options
	  @error_message = ""
	end

	def to_s
	  result = "** Rule #{url} "
      options.each do |attribute, value|
        result << "#{attribute.to_s}: #{value.to_s} "
      end
      result << "Error: #{error_message}"
    end

    def response_code
        options[:response_code]
    end

    def redirect_url
        options[:redirect_url]
    end

    def body
        options[:body]
    end

    def with_error?
        error_message != ""
    end
end