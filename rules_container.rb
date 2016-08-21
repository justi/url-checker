class RulesContainer
    attr_accessor :rules

    def initialize()
	  @rules = []
	end

    def add(rule)
        @rules << rule
    end

    def with_errors
        @rules.select { |rule| rule.with_error? }
    end

    def count
        @rules.length
    end
end