require 'prism'

module Rurubyby
  class Vm
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def run
      script = options[:script]

      if script
        puts "Executing: '#{script}'"

        parse_result = Prism.parse(script)

        # puts
        # puts "parse_result:"
        # puts parse_result.inspect

        ast = parse_result.value
        # puts
        # puts "AST:"
        # puts ast.inspect

        puts "AST root isa #{ast.class}"
      else
        puts "No script given"
      end
    end
  end
end
