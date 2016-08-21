class Rule
    attr_accessor :condition, :url, :options, :error_message

    def initialize(url, options)
	  @url = url
	  @options = options
	end

	def to_s
	  result = ""
      @options.each do |attribute, value|
        result << "#{attribute.to_s}: #{value.to_s}"
      end
    end

    def response_code
        options[:respond_code]
    end

    def redirect_url
        options[:redirect_url]
    end
end