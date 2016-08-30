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

    def errors_to_s
        res = ""
        with_errors.each { |r| res+= "#{r.to_s}\n" }
        res
    end

    def count
        @rules.length
    end
end