module Liltest
  class Expectation
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def to_eq(expectation)
      raise "Failed" if value != expectation
    end
  end
end
