module Liltest
  class Expectation
    attr_reader :value, :failed_reason

    def initialize(value)
      @value = value
    end

    def to_eq(expectation)
      if value != expectation
        @failed_reason = "Expected '#{value}' to equal '#{expectation}', but it was '#{value}'"
        raise "Failed"
      end
    end

    def failed?
      !!@failed_reason
    end
  end
end
