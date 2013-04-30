require 'liltest/expectation'
require 'liltest/request'

module Liltest
  class Case
    def self.describe(description, &block)
      block.call
    end

    def self.it(description, &block)
      @tests ||= []
      @tests << { context: @current_context, description: description, block: block }
    end

    def self.context(context_name, &block)
      @current_context = context_name
      block.call
    end

    def self.execute
      @tests.each do |test|
        begin
          test[:block].call
          $stdout.write "."
        rescue
          @failed ||= []
          @failed << test
          $stdout.write "F"
        end
      end

      write_failed_tests
      write_failed_expectations
    end

    def self.write_failed_expectations
      if @expectations
        @expectations.each do |expectation|
          if expectation.failed?
            $stdout.write "\n #{expectation.failed_reason}"
          end
        end
      end
    end

    def self.write_failed_tests
      if @failed
        $stdout.write "\n"
        @failed.each do |failed|
          $stdout.write "\n #{@current_context} #{failed[:description]} failed"
        end
      end
    end

    def self.expect(value)
      expectation = Expectation.new(value)
      @expectations ||= []
      @expectations << expectation
      expectation
    end

    def self.get(endpoint, body = nil, headers = nil)
      @response = Liltest::Request.new(:get, endpoint, body, headers)
    end

    def self.post(endpoint, body = nil, headers = nil)
      @response = Liltest::Request.new(:post, endpoint, body, headers)
    end

    def self.put(endpoint, body = nil, headers = nil)
      @response = Liltest::Request.new(:put, endpoint, body, headers)
    end

    def self.delete(endpoint, body = nil, headers = nil)
      @response = Liltest::Request.new(:delete, endpoint, body, headers)
    end

    def self.response
      @response
    end
  end
end
