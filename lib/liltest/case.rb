require 'liltest/expectation'
require 'liltest/request'

require "json"

module Liltest
  class Case
    def self.describe(description, &block)
      block.call
    end

    def self.it(description, &block)
      @tests ||= []
      @tests << { description: description, block: block }
    end

    def self.context(context_name, &block)
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

      if @failed
        $stdout.write "\n"
        @failed.each do |failed|
          $stdout.write "\n" + failed[:description] + ' failed'
        end
      end
    end

    def self.expect(value)
      Expectation.new(value)
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
